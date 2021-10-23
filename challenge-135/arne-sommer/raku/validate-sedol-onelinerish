#! /usr/bin/env raku

subset SEDOL where * ~~ /<[0..9 BCDFGHJKLMNPQRSTVWXYZ]>**6<[0..9]>/;

unit sub MAIN (SEDOL $SEDOL);

say + ($SEDOL.substr(6) eq (10 − (((^6).map({ $SEDOL.substr($_, 1).parse-base(35) * (1, 3, 1, 7, 3, 9, 1)[$_] }).sum) % 10)) % 10);