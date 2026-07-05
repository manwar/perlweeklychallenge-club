#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let sum = 0
    line . split ("") . forEach ((ch, i) => {
        if ("a" <= ch && ch <= "z") {
            sum += (i + 1) * ("z" . charCodeAt (0) - ch . charCodeAt (0) + 1)
        }
    })
    console . log (sum)
})
