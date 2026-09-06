#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let numbers = line . split (/\s+/) . map (x => +x)
    let pat = ""
    for (let i = 1; i < numbers . length; i ++) {
        if (numbers [i - 1] <  numbers [i]) {pat = pat + "0"}
        if (numbers [i - 1] == numbers [i]) {pat = pat + "1"}
        if (numbers [i - 1] >  numbers [i]) {pat = pat + "2"}
    }
    let max = 1
    pat . matchAll (/0?(?:20)*2?/g) . forEach (match => {
        if (match [0] . length >= max) {
            max = match [0] . length + 1
        }
    })
    console . log (max)
  })
