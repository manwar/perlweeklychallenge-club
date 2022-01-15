#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: node ch-2.js
//

let pentagon = {}
let p = 0
let n = 0

main: {
    while (1) {
        p += n + n + n + 1
        n ++
        pentagon [p] = 1
        for (let seen in pentagon) {
            seen = +seen
            if (seen + seen <= p && (p - seen)        in pentagon &&
                                    (p - seen - seen) in pentagon) {
                console . log (seen . toString () + " " + (p - seen))
                break main
            }
        }
    }
}
