#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let SIZE = 7
let printf = require ('printf')

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => main (_ . split (/\s+/) . map (_ => +_)))
;


function main (numbers) {
    //
    // First, we create a datastructure to collect all the
    // differences between two numbers, with the restriction
    // that the difference is present in numbers
    //
    let differences = {}
    numbers . forEach (n => differences [n] = [])

    numbers . forEach ((x, x_i) => {
        numbers . forEach ((y, y_i) => {
            if (x_i != y_i) {
                let diff = x - y
                if (differences [diff]) {
                    differences [diff] . push ([x_i, y_i])
                }
            }
        })
    })

    //
    // For each number d in numbers, with index d_i, find all pairs
    // of distinct numbers, all with index other than d_i, where the
    // differences of each pair is d.
    //
    numbers . forEach ((d, d_i) => {
        let diffs = differences [d]
        for (let x = 0; x < diffs . length; x ++) {
            //
            // Ignore any difference involving d_i
            //
            if (diffs [x] [0] == d_i || diffs [x] [1] == d_i) {
                continue
            }
            for (let y = x + 1; y < diffs . length; y ++) {
                //
                // Second diff should not involve d_i, and all its
                // elemenst should be different from the first diff
                //
                if (diffs [y] [0] == d_i || diffs [y] [1] == d_i ||
                    diffs [x] [0] == diffs [y] [0] ||
                    diffs [x] [0] == diffs [y] [1] ||
                    diffs [x] [1] == diffs [y] [0] ||
                    diffs [x] [1] == diffs [y] [1]) {
                    continue
                }
                //
                // W.l.o.g we can now assume diff [x] gives us a_i and c_i,
                // and diff [y] gives use g_i and e_i
                //
                let [a_i, c_i] = diffs [x]
                let [g_i, e_i] = diffs [y]

                //
                // Find the two possibilities for b_i and f_i
                //
                for (let b_i = 0; b_i < numbers . length; b_i ++) {
                    if (b_i == a_i || b_i == c_i || b_i == d_i ||
                        b_i == e_i || b_i == g_i) {
                        continue
                    }
                    for (let f_i = 0; f_i < numbers . length; f_i ++) {
                        if (f_i == a_i || f_i == b_i || f_i == c_i ||
                            f_i == d_i || f_i == e_i || f_i == g_i) {
                            continue
                        }
                        //
                        // Do we have a winner?
                        //
                        let target  = numbers [a_i] + numbers [b_i]
                        if (target == numbers [b_i] + numbers [c_i] +
                                      numbers [d_i] &&
                            target == numbers [d_i] + numbers [e_i] +
                                      numbers [f_i] &&
                            target == numbers [f_i] + numbers [g_i]) {
                            //
                            // Print the results, and the reverse
                            //
                            printf (process . stdout, "%d %d %d %d %d %d %d\n",
                                    numbers [a_i], numbers [b_i],
                                    numbers [c_i], numbers [d_i],
                                    numbers [e_i], numbers [f_i],
                                    numbers [g_i])
                            printf (process . stdout, "%d %d %d %d %d %d %d\n",
                                    numbers [g_i], numbers [f_i],
                                    numbers [e_i], numbers [d_i],
                                    numbers [c_i], numbers [b_i],
                                    numbers [a_i])
                        }
                    }
                }
            }
        }
    })
}
