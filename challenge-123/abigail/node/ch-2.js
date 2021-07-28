#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [x1, y1, x2, y2, x3, y3, x4, y4] = line . split (/ +/) . map (_ => +_)
    let e1 = (x1 - x2) ** 2 + (y1 - y2) ** 2
    let e2 = (x2 - x3) ** 2 + (y2 - y3) ** 2
    let e3 = (x3 - x4) ** 2 + (y3 - y4) ** 2
    let e4 = (x4 - x1) ** 2 + (y4 - y1) ** 2
    let d1 = (x1 - x3) ** 2 + (y1 - y3) ** 2
    let d2 = (x2 - x4) ** 2 + (y2 - y4) ** 2
    console . log (e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2 ? 1 : 0)
})
