#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

function dist (x1, y1, x2, y2) {
    return (x1 - x2) ** 2 + (y1 - y2) ** 2
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [x1, y1, x2, y2, x3, y3, x4, y4] = line . split (/ +/) . map (_ => +_)
    console . log (dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) &&
                   dist (x2, y2, x3, y3) == dist (x3, y3, x4, y4) &&
                   dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) &&
                   dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4) ? 1 : 0)
})
