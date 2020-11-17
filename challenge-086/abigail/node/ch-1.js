//
// Read STDIN. Split on newlines, then on whitespace, and turn the results
// into numbers. Since the input will be newline terminated, we have an
// empty line to filter out.
//
let lines = require      ("fs")
          . readFileSync (0)               // Read all.
          . toString     ()                // Turn it into a string.
          . split        ("\n");           // Split on newlines.


//
// Iterate pair wise over the lines
//
for (let i = 0; i < lines . length - 1; i += 2) {
    //
    // First line is a set of integers, split on
    // white space, and store the numbers in a hash.
    //
    let data = lines [i] . split  (" ")
                         . reduce ((acc, val) => {
        acc [val] = acc [val] ? acc [val] + 1 : 1;
        return acc;
    }, {});

    //
    // Second line is the target difference
    //
    let diff = +lines [i + 1];

    //
    // For each number in the array, check whether there is
    // another number so their difference is that target
    // difference. Special care has to be taken if the target
    // difference is 0.
    //
    let winner = 0;
    Object . keys (data) . forEach ((number) => {
        if (!winner) {
            let target = number - diff;
            if (data [target] && (diff || data [target] > 1)) {
                winner = 1;
            }
        }
    });
    console . log (winner);
}
