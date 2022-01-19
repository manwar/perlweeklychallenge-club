#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: node ch-1.js
//

function is_prime (p) {
    if (p == 2) {return true}
    if (p % 2 == 0) {return false}
    for (let i = 3; i * i <= p; i += 2) {
        if (p % i == 0) {return false}
    }
    return true
}

let todo  = [2, 3, 5, 7]
let count = 20 - todo . length

todo . forEach (p => process . stdout . write (p . toString () + " "))

let pow = 10
main: {
    while (todo . length > 0) {
        let new_todo = []
        for (let d = 1; d <= 9; d ++) {
            for (let i = 0; i < todo . length; i ++) {
                let candidate = d * pow + todo [i]
                if (is_prime (candidate)) {
                    new_todo . push (candidate)
                    process . stdout . write (candidate . toString () + " ")
                    count --
                    if (count <= 0) {
                        break main
                    }
                }
            }
        }
        todo = new_todo
        pow *= 10
    }
}

process . stdout . write ("\n")
