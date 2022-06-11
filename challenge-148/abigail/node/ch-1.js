#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: node ch-1.js
//


console . log (
    Array . from (Array (101) . keys ())
          . filter (x => !(x . toString () . match (/^0$|[1789]|^2.|[35]$/)))
          . join (" ")
)

