#!/usr/bin/env perl6
#
#
#       reptend.raku
#
#       TASK #2 › Decimal String
#         Submitted by: Mohammad S Anwar
#         You are given numerator and denominator i.e. $N and $D.
# 
#         Write a script to convert the fraction into decimal string. If the fractional part is recurring then put it in parenthesis.
# 
#         Example
#         Input: $N = 1, $D = 3
#         Output: "0.(3)"
# 
#         Input: $N = 1, $D = 2
#         Output: "0.5"
# 
#         Input: $N = 5, $D = 66
#         Output: "0.0(75)"
# 
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num = 1, Int $den = 24) ;

my ($real, $reptend) = ($num/$den).base-repeating(10);
printf '%s(%s)', $real, $reptend;     

