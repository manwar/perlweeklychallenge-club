#!/opt/homebrew/bin/node

const util = require ('node:util');
 
  require ('readline')
. createInterface ({input: process . stdin})
. on              ('line', line => {
    let [r1, i1, r2, i2] = [... line . matchAll (/-?[0-9]+/g)] . map (x => +x)
    let r  = r1 * r2 - i1 * i2
    let i  = r1 * i2 + r2 * i1
    let ft = i < 0 ? "%d+(%d)i" : "%d+%di"
    console . log (util . format (ft, r, i))
  })
