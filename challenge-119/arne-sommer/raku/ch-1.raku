#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0 && $N <= 255);
  
say ($_.substr(4) ~ $_.substr(0,4)).parse-base(2) with $N.fmt('%08b');


