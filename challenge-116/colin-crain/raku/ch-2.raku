#!/usr/bin/env perl6
#
#
#       that-cats-some-square.raku
#
#         Sum of Squares
#         Submitted by: Mohammad Meraj Zia
#         You are given a number $N >= 10.
# 
#         Write a script to find out if the given number $N is such that sum of
#         squares of all digits is a perfect square. Print 1 if it is otherwise
#         0.
# 
#         Example
#         Input: $N = 34
#         Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
# 
#         Input: $N = 50
#         Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
# 
#         Input: $N = 52
#         Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $num where {$num > 0} = 50) ;

my $sum = $num.comb
              .map(*²)
              .sum ;
              
say
$sum == (floor sqrt $sum)² 
    ?? 1
    !! 0 ;


