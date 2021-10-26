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

//
// Precalculate the powers of 2. We're losing precision around 2^53
//
let power_of_2 = {};
let power = 1;
for (let i = 1; i < 53; i ++) {
    power *= 2;
    power_of_2 [power] = 1;
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [m, n] = line . trim () . split (' ') . map (x => +x)
    console . log (power_of_2 [gcd (m, n)] || 0)
})
