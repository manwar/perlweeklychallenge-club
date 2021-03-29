#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//


require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (
              _ . split  (/\s+/)                // Split on white space
                . map    (_ => +_)              // Numify
                . sort   ()                     // Sort
                . reduce ((max, _, i, N) => {   // Find max difference
                      return i > 0 && (N [i] - N [i - 1]) > max
                                    ? (N [i] - N [i - 1]) : max
                  }, 0)))
