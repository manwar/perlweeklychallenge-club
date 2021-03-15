#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let numbers =
  require      ("fs")
. readFileSync (0)                               // Read all.
. toString     ()                                // Turn it into a string.
. split        ("\n")                            // Split on newlines.
. filter       (_ => _ . length)                 // Filter out empty lines.
. map          (_ => _ . split (/\s+/)           // Split on white space.
                       . map (_ => Number (_)))  // Convert to number.

for (let x = numbers . length - 2; x >= 0; x --) {
    for (let y = 0; y < numbers [x] . length; y ++) {
        numbers [x] [y] += Math . min (numbers [x + 1] [y],
                                       numbers [x + 1] [y + 1])
    }
}

console . log (numbers [0] [0])
