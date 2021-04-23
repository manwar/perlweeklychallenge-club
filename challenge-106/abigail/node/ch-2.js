#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => console . log (long_division (... _ . split (" ")
                                                       . map (_ => +_))))

//
// See ../README.md for info about this function
//

function long_division (numerator, denominator) {
    let BASE = 10
    let fraction = Math . floor (numerator / denominator) + "."
    let position = fraction . length
    let seen     = []

    numerator %= denominator

    while (!(numerator in seen)) {
        if (!numerator) {
            return (fraction)
        }
        seen [numerator] = position
        fraction += Math . floor (BASE * numerator / denominator)
        numerator =               BASE * numerator % denominator
        position ++
    }

    return (fraction . substr (0, seen [numerator]) + "(" +
            fraction . substr (   seen [numerator]) + ")")
}
