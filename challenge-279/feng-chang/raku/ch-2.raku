#!/bin/env raku

unit sub MAIN(Str:D $str);

put $str.lc.comb.grep(<a e i o u>.any) %% 2;
