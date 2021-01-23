#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (_ . trim    ()        // Remove leading
                                                        // and trailing
                                                        // whitespace.
                                    . split   (/\s+/)   // split ...
                                    . reverse ()        // reverse ...
                                    . join    (" ")))   // and recombine.
;
