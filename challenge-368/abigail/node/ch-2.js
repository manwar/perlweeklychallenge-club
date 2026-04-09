#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Parse the input. Extract the number and the mode, and 
    // turn them into integers
    //
    let [number, mode] = line . split (" ") . map ((x) => +x)

    let diff_factors = 0
    let      factors = 0

    //
    // Try dividing by all odd numbers -- but use 2 if the number is 1.
    // Count different and total factors.
    //
    // Note that this way, we will never divide by a composite number --
    // if we encounter a composite number, we have already tried its factors.
    //
    for (let d = 1; d * d <= number; d += 2) {
        let n = d == 1 ? 2 : d
        if (number % n == 0) {
            diff_factors ++
            while (number % n == 0) {
                factors ++
                number /= n
            }
        }
    }

    //
    // At this point, $number is either 1 or a large prime, not encountered
    // before. In the later case, add one of the number of factors and unique
    // factors.
    //
    if (number != 1) {
        diff_factors ++
        factors ++
    }

    console . log (mode == 1 ? factors : diff_factors)
  })
