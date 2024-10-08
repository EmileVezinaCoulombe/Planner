//***************************************************************************//
// Imports                                                                   //
//***************************************************************************//
#import "@preview/splash:0.3.0": tailwind

//***************************************************************************//
// Variables                                                                 //
//***************************************************************************//
#let cours = (
    "Vision",
    "Q & M",
    "Architecture",
    "Réseaux",
    "IA",
    "PGL",
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

#let weeks-sm = ()
#let weeks-sm-hidden = ()
#let textBox(..x) = box(width: 9pt, height: 9pt, stroke: 0.5pt + black, radius: 2pt, ..x)
#for i in array.range(1, weeksNb) {
    weeks-sm.push(align(center + horizon, checkBox()[#text(8pt)[#i]] ))
    weeks-sm-hidden.push(checkBox()[])
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

#let weeklyTodoNb = 21
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
#set page(paper: "a4", margin: (x: 1cm, y: 0.5cm))
#set par(justify: true, leading: 0.52em)
#set align(center)

//***************************************************************************//
// Page 1 : Today                                                            //
//***************************************************************************//
#grid(
    columns: 1, rows: 3, row-gutter: 3em, [= Today],
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
            fill: (_, row) => if row == 0 { tailwind.neutral-100 } else if row > taskNb - 2 { tailwind.teal-100 },
            [*Time*], [*Task*], [*C*], ..tasks.flatten(),
        )

    ],
)

#pagebreak()
//***************************************************************************//
// Page 2: Blank                                                             //
//***************************************************************************//
#hide[Blank]

#pagebreak()

//***************************************************************************//
// Page 3: Weekly                                                            //
//***************************************************************************//
#grid(
    columns: 1, rows: 3, row-gutter: 3em, [
        = Weekly
    ],
    [

        #grid(
            columns: (1fr, 1fr), [
                #set align(left)
                #grid(
                    columns: (2.9em, 1fr), [#text(12pt)[Week]], [#grid(columns: weeksNb + 1, column-gutter: 1fr, ..weeks-sm)],
                )
                #v(-0pt)
                #for class in cours {
                    text(12pt, underline()[#class])
                    text(
                        10pt, list(
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
                        12pt, grid(
                            columns: (habitLenght, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: 20, [#align(left)[#text(12pt)[Habits]]],
                            [Mon], [Tue], [Wed], [Thur],
                            [Fri], [Sat], [Sun],
                        ),
                    ),
                )
            ], [
                #pad(y: 12pt, [#underline-lg()[]#uInput-lg()])
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
                #let underline-offset = 9pt
                #let uEmptyInput(..box_args) = box(
                    width: 1fr, stroke: (bottom: underline-thickness), outset: (bottom: underline-offset),
                    ..box_args,
                )
                #set text(12pt)
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
            columns: 1, rows: 3, align(center + bottom, text(12pt, grid(
                columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: 1, [Mon], [Tue],
                [Wed], [Thur], [Fri], [Sat],
                [Sun],
            ))), [#pad(y: 6pt, [#underline-lg()[]#uInput-lg()])],
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

#pagebreak()
//***************************************************************************//
// Page 4: Calendar                                                          //
//***************************************************************************//


#import table
#let firstHour = 7
#let lastHour = 18
#let weekHours = ()
#for i in array.range(firstHour, lastHour) {
    weekHours.push((table.cell(rowspan: 4, stroke: none, align: horizon)[#text(8pt, [#i:00])], [], [], [], [], [], [], []))
    weekHours.push(( [], [], [], [], [], [], []))
    weekHours.push(( [], [], [], [], [], [], []))
    weekHours.push(( [], [], [], [], [], [], []))
    weekHours.push(table.hline(stroke: (thickness: 1pt)))
}

#let dayLenght = 8em
#v(4em)
#rotate(90deg)[
#table(
    columns: (3em, dayLenght, dayLenght, dayLenght, dayLenght, dayLenght, dayLenght, dayLenght),
    stroke: 0.2pt,
    inset: (y: 5.5pt),
    fill: (_, row) => if row == 0 { tailwind.neutral-100 },
    table.hline(stroke: none),
    table.vline(stroke: none),
    [Time], [Mon], [Tue], [Wed], [Thur], [Fri], [Sat], table.cell(stroke: none, [Sun]),
    table.vline(start: 1, stroke: 1pt),
    table.hline(stroke: 1pt),
    ..weekHours.flatten(),
    table.hline(stroke: (thickness: 1pt)),
    table.cell(inset: 11pt, align: horizon)[over time], [], [], [], [], [], [], [],
    table.hline(stroke: 1pt),
)
]
