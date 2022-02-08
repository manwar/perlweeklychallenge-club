#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
//

//
// Run as: node ch-1.js < input-file
//

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {
    let tree = line . split ("\|") . map (row => row . trim () . split (/ +/))

    for (let d = 0; d < tree . length; d ++) {
        if (d == tree . length - 1) {
            return
        }
        let c_row = tree [d]
        let n_row = tree [d + 1]
        for (let i = 0; i < c_row . length; i ++) {
            let ch1 = 2 * i
            let ch2 = 2 * i + 1
            if (c_row [i] != "*"                                   &&
                     (ch1 >= n_row . length || n_row [ch1] == "*") &&
                     (ch2 >= n_row . length || n_row [ch2] == "*")) {
                console . log (d + 1)
                return;
            }
        }
    }
})
