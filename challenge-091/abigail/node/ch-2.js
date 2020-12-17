//
// Read STDIN. Split on newlines, filter out empty lines,
// split each line on white space, then call "show"
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => _ . split (/\s+/)   // Split on whitespace.
                       . map (_ => +_))  // And numify the parts.
. map          (_ => hop (_))
;

//
// Do the main work
//
function hop (array) {
    let i;
    for (i = 0; i < array . length - 1; i += array [i]) {}
    process . stdout . write (i == (array . length - 1) ? "1\n" : "0\n");
}
