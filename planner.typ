//***************************************************************************//
// Imports                                                                   //
//***************************************************************************//
#import "@preview/splash:0.3.0": tailwind

//***************************************************************************//
// Variables                                                                 //
//***************************************************************************//
#let cours = (
    "Algo", "Santé & Sécurité", "Analyse numérique", "Interface",
    "Spécification",
)

#let checkBox(..x) = box(width: 10pt, height: 10pt, stroke: 1pt + black, radius: 2pt, ..x)
#let underline-thickness = 0.5pt
#let underline-offset = 1pt
#let underline-100(..x) = underline(stroke: underline-thickness, offset: underline-offset, ..x)
#let uInput-100(..box_args) = box(
    width: 1fr, stroke: (bottom: underline-thickness), outset: (bottom: underline-offset),
    ..box_args,
)

#let underline-thickness = 1.5pt
#let underline-offset = -2pt
#let underline-lg(..x) = underline(stroke: underline-thickness, offset: underline-offset, ..x)
#let uInput-lg(..box_args) = box(
    width: 1fr, stroke: (bottom: underline-thickness), outset: (bottom: underline-offset),
    ..box_args,
)

#let uInput-time(..box_args) = box(width: 1em, stroke: (bottom: 0.5pt), outset: (bottom: 5pt), ..box_args)

#let weeksNb = 16
#let weeks = ()
#let textBox(..x) = box(outset: 3pt, stroke: 1pt + black, radius: 2pt, ..x)
#for i in array.range(1, weeksNb) {
    weeks.push(textBox()[
        #i
    ])
}
#let weeks-sm = ()
#let weeks-sm-hidden = ()
#let textBox(..x) = box(width: 7pt, height: 7pt, stroke: 0.5pt + black, radius: 2pt, ..x)
#for i in array.range(1, weeksNb) {
    weeks-sm.push(align(center + horizon, text(6pt, textBox()[
        #i
    ])))
    weeks-sm-hidden.push(text(6pt, textBox()[
    ]))
}

#let topTodoNb = 3
#let topTodos = ()
#for i in range(topTodoNb) {
    topTodos.push([#checkBox() #underline-100[]#uInput-100()])
}

#let dailyTodoNb = 11
#let dailyTodos = ()
#for i in array.range(dailyTodoNb) {
    dailyTodos.push(
        [#pad(left: 12pt, right: 8pt, [#checkBox() #underline[]#uInput-100()])],
    )
}

#let weeklyTodoNb = 13
#let weeklyTodos = ()
#for i in array.range(weeklyTodoNb) {
    weeklyTodos.push(
        [#pad(left: 12pt, right: 8pt, [#checkBox() #underline-100[]#uInput-100()])],
    )
}

//***************************************************************************//
// Settings                                                                  //
//***************************************************************************//
#set document(
    title: [Planner], author: "Émile Vézina-Coulombe", keywords: "habits", date: datetime(year: 2024, month: 2, day: 1),
)

#set text(font: "New Computer Modern", size: 12pt)
#set page(paper: "a5", margin: (x: 1cm, y: 0.5cm))
#set par(justify: true, leading: 0.52em)
#set align(center)

//***************************************************************************//
// Page 1 : Today                                                            //
//***************************************************************************//
#grid(
    columns: 1, rows: 3, row-gutter: 1fr, [= Today],
    [
        #grid(
            columns: (1fr, 1fr), gutter: 1em, [
                #grid(columns: 1, rows: 4, row-gutter: 9pt, [== Top 3], ..topTodos)

                #let notesNb = 7
                #let notes = ()
                #for i in range(notesNb) {
                    notes.push([#underline-100[]#uInput-100()])
                }
                #grid(columns: 1, rows: notesNb + 1, row-gutter: 19pt, [== Notes], ..notes)
            ], [
                #box(
                    stroke: (left: 1pt, bottom: 1pt), inset: (bottom: 10pt),
                )[
                    #grid(
                        columns: 1, rows: dailyTodoNb + 1, row-gutter: 9pt, [
                            #text(12pt)[#pad(x: 4pt, [#underline-100(extent: 4pt)[TODO]#uInput-100()])]
                        ],
                        ..dailyTodos,
                    )
                ]
            ],
        )
    ], [
        == Done this day

        #let taskNb = 10
        #let tasks = ()
        #for i in array.range(taskNb) {
            tasks.push(
                (
                    [#underline-100()[]#uInput-time():#underline-100()[]#uInput-time() | #underline-100()[]#uInput-time():#underline-100()[]#uInput-time()],
                    [], [],
                ),
            )
        }
        #table(
            columns: (7em, 1fr, 3em), rows: taskNb + 1, inset: 8pt, align: (x, y) => (center, center, center, center).at(x),
            fill: (_, row) => if row == 0 { tailwind.neutral-100 } else if row > taskNb - 2 { tailwind.teal-100 } else { white },
            [*Time*], [*Task*], [*C*], ..tasks.flatten(),
        )

    ],
)

#pagebreak()
//***************************************************************************//
// Page 2: Weekly                                                            //
//***************************************************************************//
#grid(
    columns: 1, rows: 3, row-gutter: 1fr, [
        = Weekly
    ],
    [

        #grid(
            columns: (1fr, 1fr), [
                #set align(left)
                #grid(
                    columns: (2.9em, 1fr), [#text(10pt)[Week]], [#grid(columns: weeksNb + 1, column-gutter: 1fr, ..weeks-sm)],
                )
                #v(-4pt)
                #for class in cours {
                    text(10pt, underline()[#class])
                    text(
                        8pt, list(
                            [#grid(
                                    columns: (3em, 1fr), [ex], grid(columns: weeksNb + 1, column-gutter: 1fr, ..weeks-sm-hidden),
                                )], [#grid(
                                    columns: (3em, 1fr), [cours], grid(columns: weeksNb + 1, column-gutter: 1fr, ..weeks-sm-hidden),
                                )], [#grid(
                                    columns: (3em, 1fr), [lec.], grid(columns: weeksNb + 1, column-gutter: 1fr, ..weeks-sm-hidden),
                                )],
                        ),
                    )
                }
            ], [
                #box(
                    stroke: (left: 1pt, bottom: 1pt), inset: (bottom: 10pt),
                )[
                    #grid(
                        columns: 1, rows: weeklyTodoNb + 1, row-gutter: 9pt, [
                            #text(12pt)[#pad(x: 4pt, [#underline-100(extent: 4pt)[TODO]#uInput-100()])]
                        ],
                        ..weeklyTodos,
                    )
                ]
            ],
        )
    ], [

        //***************************************************************************//
        // Habit tracker                                                             //
        //***************************************************************************//

        #let habitLenght = 8fr
        #grid(
            columns: 1, rows: 3, [
                #align(
                    center + bottom, text(
                        8pt, grid(
                            columns: (habitLenght, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: 20, [#align(left)[#text(10pt)[Habits]]],
                            [Mon], [Tue], [Wed], [Thur],
                            [Fri], [Sat], [Sun],
                        ),
                    ),
                )
            ], [
                #pad(y: 8pt, [#underline-lg()[]#uInput-lg()])
            ],
            [
                #let underline-thickness = 0.5pt
                #let underline-offset = 1pt
                #let underline-lg(..x) = underline(stroke: underline-thickness, offset: underline-offset, ..x)
                #let uInput(..box_args) = box(
                    width: 1fr, stroke: (bottom: underline-thickness), outset: (bottom: underline-offset),
                    ..box_args,
                )
                #let underline-thickness = 0.5pt
                #let underline-offset = 8pt
                #let uEmptyInput(..box_args) = box(
                    width: 1fr, stroke: (bottom: underline-thickness), outset: (bottom: underline-offset),
                    ..box_args,
                )
                #set text(10pt)
                #grid(
                    columns: (habitLenght, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), row-gutter: 5pt,
                    [#underline-lg()[Planner]#uInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#underline-lg()[Top 3 checked]#uInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#underline-lg()[10 Flashcards]#uInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#underline-lg()[1 page AI book]#uInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#underline-lg()[5 words]#uInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#uEmptyInput()], [#checkBox()], [#checkBox()], [#checkBox()],
                    [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                )
            ],
        )
    ], [
        //***************************************************************************//
        // Evaluations                                                               //
        //***************************************************************************//
        == Evaluations

        #grid(
            columns: 1, rows: 3, align(center + bottom, text(8pt, grid(
                columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: 1, [Mon], [Tue],
                [Wed], [Thur], [Fri], [Sat],
                [Sun],
            ))), [#pad(y: 8pt, [#underline-lg()[]#uInput-lg()])],
            grid(
                columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: 2, row-gutter: 10pt, [#checkBox()],
                [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                [#checkBox()], [#checkBox()], [#checkBox()], [#checkBox()],
                [#checkBox()],
            ),
        )
    ],
)
