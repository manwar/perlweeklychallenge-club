#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $input where {$input > 0} = 1000) ;

my $out = (1..$input).combinations(2)
                     .map({[gcd] |$_})
                     .sum;

say "input $input";
say "sum   $out";
