#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => console . log (LevenshteinDistance (_ . trim ()
                                                           . split (/\s+/))))
;

//
// This is an implementation of the Wagner Fischer algorithm, which
// calculates the Levenshtein distance.
//
// See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
//
function LevenshteinDistance (strings) {
    let first  = strings [0] . split ("");
    let second = strings [1] . split ("");

    let distance = [];

    let N = first  . length;
    let M = second . length;

    for (let i = 0; i <= N; i ++) {
        distance [i] = [];
        for (let j = 0; j <= M; j ++) {
            distance [i] [j] =
                i == 0 || j == 0 ? i + j
              : Math . min (distance [i - 1] [j]     + 1,
                            distance [i]     [j - 1] + 1,
                            distance [i - 1] [j - 1] +
                               (first  [i - 1] ==
                                second [j - 1] ? 0 : 1))
        }
        if (i) {
            distance [i - 1] = 0
        }
    }
    return distance [N] [M]
}
