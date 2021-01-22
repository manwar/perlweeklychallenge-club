#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => console . log (_ . trim    ()        // Remove leading
                                                          // and trailing
                                                          // whitespace.
                                      . split   (/\s+/)   // split ...
                                      . reverse ()        // reverse ...
                                      . join    (" ")))   // and recombine.
;
