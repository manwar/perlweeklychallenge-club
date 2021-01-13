#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num = 2244444431111111) ;

say $num;

my $regex = /1+|2+|3+|4+|5+|6+|7+|8+|9+|0+/;

($num ~~ m:g/$regex/)
    .map({|($_.chars, substr($_,0,1))})     ## need slip to slip in
    .join
    .say;


