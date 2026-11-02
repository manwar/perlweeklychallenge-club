#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let sum   = 0
    let count = 0
    line . split (/\s+/) . map (x => +x) . forEach (number => {
        if (number % 6 == 0) {
            sum   += number
            count ++
        }
    })

    console . log (sum ? Math . round (sum / count) : 0)
})
