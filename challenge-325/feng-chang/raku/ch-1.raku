#!/bin/env raku

unit sub MAIN(Str:D $s where *.comb.all == 0|1);

put max(0, |$s.match(/1+/, :g).map(*.chars));
