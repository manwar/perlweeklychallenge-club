#!/usr/bin/env perl6
# 
#
#       power-to-the-wholes.raku
#
#         TASK #2 › Power of Two Integers
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to find if it can be expressed as a ^ b 
#         where a > 0 and b > 1. Print 1 if you succeed otherwise 0.
# 
# 
#         Example 1:
#             Input: 8
#             Output: 1 as 8 = 2 ^ 3
# 
#         Example 2:
#             Input: 15
#             Output: 0
# 
#         Example 3:
#             Input: 125
#             Output: 1 as 125 = 5 ^ 3

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $input where $input > 0 = 823543) ;  ## 7^7

for 2..sqrt $input -> $try {
    my $copy = $input;
    while $copy %% $try and $copy /= $try {
        $copy == 1 and 1.say and exit;
    }
}
0.say;

