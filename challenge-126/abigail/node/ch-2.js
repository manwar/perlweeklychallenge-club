#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let board = []

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', _ => {board . push (_ . trim () . split (" "))})
. on              ('close',  () => {
    let X = board . length
    let Y = board [0] . length
    for (x = 0; x < X; x ++) {
        for (y = 0; y < Y; y ++) {
            if (y != 0) {
                process . stdout . write (" ")
            }
            if (board [x] [y] == "x") {
                process . stdout . write ("x")
                continue
            }
            let count = 0
            for (dx = -1; dx <= 1; dx ++) {
                if (x + dx < 0 || x + dx >= X) {
                    continue
                }
                for (dy = -1; dy <= 1; dy ++) {
                    if (x + dx < 0 || x + dx >= X) {
                        continue
                    }
                    if (dx == 0 && dy == 0) {
                        continue
                    }
                    if (board [x + dx] [y + dy] == "x") {
                        count ++
                    }
                }
            }
            process . stdout . write (count . toString ())
        }
        process . stdout . write ("\n")
    }
})

