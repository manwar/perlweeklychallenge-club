//
// Read STDIN. Split on newlines, filter out empty lines, then call "main".
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => {
    //
    // replace() returns the modified string, so we do a separate
    // match to get the actual count of the number of 'e's
    //
    count = [... _ . matchAll (/e/g)] . length;
    //
    // Do the replacement, and print the results. Print also
    // the number of times 'e' appears.
    //
    process . stdout . write (_ . replace (/e/g, "E") + "\n" + count + "\n")
})
;
