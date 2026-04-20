#!/bin/env raku

unit sub MAIN(Str:D $str where $str.comb.all eq <0 1>.any && $str > 0);

my $one-cnt = $str.comb.sum;
put '1' x ($one-cnt - 1), '0' x ($str.chars - $one-cnt), '1';
