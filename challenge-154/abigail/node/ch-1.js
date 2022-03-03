#!/usr/local/bin/node

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
//

//
// Run as: node ch-1.js < input-file
//

let p = {PERL: 1, PELR: 1, PREL: 1, PRLE: 1, PLER: 1, PLRE: 1,
         EPRL: 1, EPLR: 1, ERPL: 1, ERLP: 1, ELPR: 1, ELRP: 1,
         REPL: 1, RELP: 1, RPEL: 1, RPLE: 1, RLEP: 1, RLPE: 1,
         LERP: 1, LEPR: 1, LREP: 1, LRPE: 1, LPER: 1, LPRE: 1,}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', line => {delete p [line . trim ()]})
. on              ('close', () => {Object . keys (p) .
                                   forEach ((key) => console . log (key))})
