#!/opt/homebrew/bin/node

let ord_a = "a" . charCodeAt ()
let ord_0 = "0" . charCodeAt ()
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Split the input line into characters, map letters to digits,
    // then rejoin to a string
    //
    line = line . trim () . split ("") . map ((ch) => {
        if ("a" <= ch && ch <= "j") {
            ch = String . fromCharCode (ch . charCodeAt () - ord_a + ord_0)
        }
        return ch
    }) . join ("")

    //
    // Split into parts, numify the parts
    //
    let [n1, n2, sum] = line . split (" ") . map (x => +x)

    //
    // Check the sum
    //
    console . log (n1 + n2 == sum ? "true" : "false")
  })
