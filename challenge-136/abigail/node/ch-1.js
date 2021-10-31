#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

//
// Find the GCD, using Euclids algorithm
//    (https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations)
//
function gcd (a, b) {
    if (b >  a) {return gcd (b, a)}
    if (b == 0) {return a}
                 return gcd (b, a % b)
}

function is_power_of_n (number, n) {
    if (number <  1) {return false}
    if (number == 1) {return true}
    if (number %  n) {return false}
                      return is_power_of_n (number / n, n)
}

function is_power_of_2 (number) {
    return is_power_of_n (number, 2)
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [m, n] = line . trim () . split (' ') . map (x => +x)
    let  r     = gcd (m, n)
    if (r > 1 && is_power_of_2 (r)) {
        console . log (1)
    }
    else {
        console . log (0)
    }
})
