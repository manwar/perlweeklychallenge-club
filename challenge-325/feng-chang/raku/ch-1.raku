#!/bin/env raku

unit sub MAIN(Str:D $s where *.comb».Int.all == 0|1);

put (0, |$s.match(/'1'+/, :g).map(*.chars)).max;
