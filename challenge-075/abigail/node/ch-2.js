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
    let heights = line . split (" ") . map (_ => +_)
    let max_height = Math . max (... heights)

    let max_area = 0
    let i, h
    for (h = 1; h <= max_height; h ++) {
        let cur = 0
        let max = 0
        for (i = 0; i < heights . length; i ++) {
            if (heights [i] >= h) {
                cur ++
            }
            else {
                if (max < cur) {
                    max = cur
                }
                cur = 0
            }
        }
        if (max < cur) {
            max = cur
        }

        let area = max * h
        if (max_area < area) {
            max_area = area
        }
    }
    console . log (max_area)
})
