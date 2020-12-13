let indent  = "                      ";
let line    = indent . replace (/ /g, "-");
let spacing = "  ";

//
// Read STDIN. Split on newlines, filter out empty lines,
// split each line on white space, then call "show"
//
  require      ("fs")
. readFileSync (0)               // Read all.
. toString     ()                // Turn it into a string.
. split        ("\n")            // Split on newlines.
. filter       (_ => _ . length) // Filter out empty lines.
. map          (_ => _ . split (/\s+/))
. map          (_ => show (_ [0], _ [1]))
;

//
// Return a number, padded with space to the required width.
// If width is less than the length of n, bad things may happen.
//
function format_n (n, width) {
    return (indent + n) . substr (-width);
}

//
// Do the main work
//
function show (A, B) {
    let P    = A * B;
    let w_A  = ("" + A) . length;
    let w_P  = ("" + P) . length;
    let tick = String . fromCodePoint (0x2713);

    while (A) {
        process . stdout . write (format_n (A, w_A)   + spacing +
                                  format_n (B, w_P)   + " "     +
                                  (A % 2 ? tick : "") + "\n");
        A = Math . floor (A / 2);
        B = B * 2;
    }

    process . stdout . write (indent . substr (-w_A) + spacing +
                              line   . substr (-w_P) + " +\n");
    process . stdout . write (indent . substr (-w_A) + spacing +
                                                  P  + "\n");
}
