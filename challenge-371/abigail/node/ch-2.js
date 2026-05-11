#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Parse the input; split on whitespace and turn the results into integers
    //
    let numbers = line . split (" ") . map (x => +x)

    //
    // Iterate over all mask for the powerset, except the empty
    // set and the full set
    //
    for (let mask = 1; mask < 2 ** numbers . length - 1; mask ++) {
        let set = []
        let sum = 0
        for (let index = 0; index < numbers . length; index ++) {
            //
            // If the position of a number is in the mask, add the
            // difference between the number and its position to the sum,
            // and add the number to the current set
            //
            if (mask & (1 << index)) {
                sum += numbers [index] - index - 1
                set . push (numbers [index])
            }
        }

        //
        // If the sum equals 0, the sum of the numbers equals the sum
        // of their postion. And if we have more than 1 number in the
        // set, print the set
        //
        if (sum == 0 && set . length > 1) {
            process . stdout . write (set . join (" ") + "; ")
        }
    }
    process . stdout . write ("\n")
  })
