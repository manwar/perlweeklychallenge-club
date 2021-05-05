#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-2.js < input-file
//

let longest = ""

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    if (_ . match (/^a*b*c*d*e*f*g*i*j*k*l*m*n*o*p*q*r*s*t*u*v*w*x*y*z*$/i) &&
        _ . length > longest . length) {
        longest = _
    }
})
. on ('close', _ => {
    console . log (longest)
})
