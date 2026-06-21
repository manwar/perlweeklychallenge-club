#!/opt/homebrew/bin/node
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let max = -1
    let sec = -1
    line . matchAll (/[0-9]/g) . forEach ((match) => {
        let ch = +match [0]
        if      (max < ch)             {sec = max; max = ch}
        else if (max > ch && ch > sec) {sec = ch}
    })
    console . log (sec)
  })
