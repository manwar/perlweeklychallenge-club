#!/usr/bin/env perl6
#
#
#       Wagner–Fischer-Price.pl
#
#         TASK #2 › Edit Distance
#         Submitted by: Mohammad S Anwar
#         You are given two strings $S1 and $S2.
# 
#         Write a script to find out the minimum operations required to convert
#         $S1 into $S2. The operations can be insert, remove or replace a
#         character. Please check out Wikipedia page for more information.
#             https://en.wikipedia.org/wiki/Edit_distance
# 
#         Example 1:
#             Input: $S1 = "kitten"; $S2 = "sitting"
#             Output: 3
# 
#                 Operation 1: replace 'k' with 's'
#                 Operation 2: replace 'e' with 'i'
#                 Operation 3: insert 'g' at the end
#                 
#         Example 2:
#             Input: $S1 = "sunday"; $S2 = "monday"
#             Output: 2
# 
#                 Operation 1: replace 's' with 'm'
#                 Operation 2: replace 'u' with 'o'

#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $s = 'Sunday', Str $t = 'Saturday') ;

my ($m, $n) = ($s, $t).map: {.chars};
my @mat;

@mat[$_][0] = $_ for 0..$m;
@mat[0]     = 0..$n;

for (1..$n) -> $j {
    for (1..$m) -> $i {  
        @mat[$i][$j] = ( @mat[$i-1][$j] + 1,
                         @mat[$i][$j-1] + 1,
                         @mat[$i-1][$j-1] + ($s.substr($i-1,1) ne $t.substr($j-1,1)).Int  ).min;
    }
}

say @mat[$m;$n];

