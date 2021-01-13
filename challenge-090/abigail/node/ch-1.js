//
// Read STDIN. Split on newlines
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => {
    process . stdout . write (_ . length + "\n" +
                              _ . replace (/A/g, 'x')
                                . replace (/T/g, 'A')
                                . replace (/x/g, 'T')
                                . replace (/G/g, 'y')
                                . replace (/C/g, 'G')
                                . replace (/y/g, 'C') + "\n")
});
