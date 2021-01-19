//
// Read STDIN. Split on newlines, filter out empty lines, then call "main".
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
