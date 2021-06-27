#!/usr/bin/env perl6
#
#
#       bin-pal.raku
#
#       Binary Palindrome
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to find out if the binary representation of the given
#         integer is Palindrome. Print 1 if it is otherwise 0.
# 
#         Example
#         Input: $N = 5
#         Output: 1 as binary representation of 5 is 101 which is Palindrome.
# 
#         Input: $N = 4
#         Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num = 153) ;

say
$num.base(2) ~~ m:ex/^ (.*) {} .? "{$0.flip}" $/ 
    ?? 1
    !! 0 ;


