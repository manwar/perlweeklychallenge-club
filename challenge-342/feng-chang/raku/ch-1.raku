#!/bin/env raku

unit sub MAIN(Str:D $s);

my ($chars, $digits) = .grep(/<[a..z]>/).sort, .grep(/<[0..9]>/).sort with $s.comb.Array;
put '"', do given +$digits - +$chars {
    when 0|1 { roundrobin(@$digits, @$chars )».join.join }
    when -1  { roundrobin(@$chars,  @$digits)».join.join }
    default  { '' }
}, '"';
