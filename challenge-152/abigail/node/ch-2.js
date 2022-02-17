#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
//

//
// Run as: node ch-2.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let [a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2] = 
         line . trim () . split (/ +/) . map (n => +n)
    console . log (       (Math . max (a_x1, a_x2) - Math . min (a_x1, a_x2))  *
                          (Math . max (a_y1, a_y2) - Math . min (a_y1, a_y2))  +
                          (Math . max (b_x1, b_x2) - Math . min (b_x1, b_x2))  *
                          (Math . max (b_y1, b_y2) - Math . min (b_y1, b_y2))  -
Math . max (0, Math . min (Math . max (a_x1, a_x2),  Math . max (b_x1, b_x2))  -
               Math . max (Math . min (a_x1, a_x2),  Math . min (b_x1, b_x2))) *
Math . max (0, Math . min (Math . max (a_y1, a_y2),  Math . max (b_y1, b_y2))  -
               Math . max (Math . min (a_y1, a_y2),  Math . min (b_y1, b_y2))))

})
