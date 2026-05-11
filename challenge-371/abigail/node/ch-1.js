#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    //
    // Split the line of input on whitespace, and turn each letter
    // in its character value
    //
    var letters = line . split (/\s/) . map ((ch) => ch . charCodeAt (0))

    //
    // Find the position of the question mark
    //
    var qi
    for (var i = 0; i < letters . length; i ++) {
        if (letters [i] == "?" . charCodeAt (0)) {
            qi = i
            break
        }
    }

    //
    // Find the values we need to calculate the missing character
    //
    var base = letters [qi <= 2 ? qi + 1 :                    qi - 1]
    var from = letters [qi <  2 ? qi + 3 : qi == 2 ? qi - 1 : qi - 3]
    var to   = letters [qi <  2 ? qi + 2 :                    qi - 2]

    //
    // Calculate the missing character and print it
    //
    console . log (String . fromCharCode (base - from + to))
  })
