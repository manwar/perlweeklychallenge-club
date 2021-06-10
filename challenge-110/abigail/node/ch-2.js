#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let out = []

  require      ("fs")
. readFileSync (0)                     // Read all.
. toString     ()                      // Turn it into a string.
. split        ("\n")                  // Split on newlines.
. filter       (_ => _ . length)       // Filter out empty lines.
. map          (_ => _ . split (','))  // Split each line on commas
. forEach      (_ => _ .
      forEach ((field, index) => {     // Create output strings
           if (out [index] == null) {
               out [index] = ""
           }
           out [index] += "," + field
      }))

out . forEach (_ => console . log (_ . substr (1))) // Print the output
                                                    // strings, skipping the
                                                    // leading comma.
