#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let [input, digit] = line . split (" ")
    let n = 0  // Indicates whether the first replacement works
    if (digit != "9") {
        //
        // Find the first occurrence of the digit which is followed by
        // larger digit, and remove that digit.
        //
        // We're using a replacement function here to signal we did a 
        // replacement (setting n to a non-zero value).
        //
        let pat = new RegExp (digit + "(?=[" + (+digit + 1) + "-9])")
        input = input . replace (pat, function () {n = 1; return ""})
    }
    if (n == 0) {
        //
        // If the block above didn't do a replacement, replace the
        // last occurrence of the digit with an empty string.
        //
        let pat = new RegExp ("(.*)" + digit)
        input = input . replace (pat, "$1")
    }
    console . log (input)
  })
