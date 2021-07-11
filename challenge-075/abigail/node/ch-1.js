#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

function possibilities (target, coins, from, to) {
    if (target == 0) {
        return (1)
    }
    if (target < 0 || from > to) {
        return (0)
    }

    let sum = 0
    let i
    for (i = 0; i * coins [from] <= target; i ++) {
        sum += possibilities (target - i * coins [from], coins, from + 1, to)
    }

    return sum
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let coins = line . split (' ') . map (_ => +_)
    console . log (possibilities (coins [0], coins, 1, coins . length - 1))
})
