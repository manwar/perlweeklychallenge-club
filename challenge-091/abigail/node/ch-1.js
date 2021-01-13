//
// Read STDIN. Split on newlines, filter out empty lines,
// split each line on white space, then call "show"
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => _ . replace (/([0-9])\1*/g,
                                  (mtch, p1) => mtch . length + p1))
                                 // Replace
. map          (_ => process . stdout . write (_ + "\n"))
                                 // Print
;
