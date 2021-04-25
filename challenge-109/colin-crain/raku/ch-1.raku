#!/usr/bin/env perl6
#
#
#       chowla.raku
#
#       TASK #1 › Chowla Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Chowla Numbers, named after, Sarvadaman D. S. Chowla, a London born Indian American mathematician. It is defined as:
# 
#         C(n) = sum of divisors of n except 1 and n
#
#         Output:
#         0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21
#
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

for 1..20 {
     printf "C(%d)%*s= %s\n", $_,  3 - $_.chars, ' ', sum_divisors($_);  
}

sub sum_divisors ($n) {
    [+] (2..sqrt $n).grep({$n %% $_})
                    .map({$n/$_ == $_ ?? $_
                                      !! $_ + $n/$_})
}

