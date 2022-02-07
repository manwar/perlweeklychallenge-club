#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let houses = line . trim () . split (/ +/) . map (n => +n)
    let best   = []
    for (let i = houses . length - 1; i >= 0; i --) {
        best [i] =
            2 >  houses . length     ?             houses [i]
          : i == houses . length - 1 ?             houses [i]
          : i == 0                   ?             houses [i] + best [i + 2]
          : i == houses . length - 2 ? Math . max (houses [i],  best [i + 1])
          :                            Math . max (houses [i] + best [i + 2],
                                                                best [i + 1])
    }
    console . log (best [0])
})
