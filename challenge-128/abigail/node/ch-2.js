#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let first_line = 1
let arrivals   = []
let departures = []

  require         ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let times = line . match (/[0-9][0-9]:[0-9][0-9]/g)
                     . map (_ => _ . split (/:/) . map (_ => +_))
                     . map (_ => 60 * _ [0] + _ [1])
    if (first_line) {
        arrivals   = times
        first_line = 0
    }
    else {
        departures = times
    }
})
. on              ('close', () => {
    let trains = []
    for (i = 0; i < 24 * 60; i ++) {
        trains [i] = 0
    }
    arrivals . forEach ((arrival, index) => {
        let departure = departures [index]
        for (i = arrival; i <= departure; i ++) {
            trains [i] ++
        }
        if (arrival > departure) {
            for (i = 0; i <= departure; i ++) {
                trains [i] ++
            }
            for (i = arrival; i < 24 * 60; i ++) {
                trains [i] ++
            }
        }
    })
    console . log (Math . max (... trains))
})
