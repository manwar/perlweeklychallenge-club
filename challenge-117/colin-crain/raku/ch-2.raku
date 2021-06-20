#!/usr/bin/env perl6
#
#
#       triangular-tour.raku
#
#       Find Possible Paths
#         Submitted by: E. Choroba
#         You are given size of a triangle.
# 
#         Write a script to find all possible paths from top to the bottom right
#         corner.
# 
#         In each step, we can either move horizontally to the right (H), or
#         move downwards to the left (L) or right (R).
# 
#         BONUS: Try if it can handle triangle of size 10 or 20.
# 
#         Example 1:
#         Input: $N = 2
# 
#                    S
#                   / \
#                  / _ \
#                 /\   /\
#                /__\ /__\ E
# 
#         Output: RR, LHR, LHLH, LLHH, RLH, LRH
#         Example 2:
#         Input: $N = 1
# 
#                    S
#                   / \
#                  / _ \ E
# 
#         Output: R, LH
# 
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


unit sub MAIN (Int $tri-size = 5) ;

my @mat = (0..$tri-size).map({ ('L' x $_ ).Array });

for 1..$tri-size -> $pos {
    my @next;
    for $pos..$tri-size -> $level {
        @next[$level-1].defined && 
            @next[$level].push: |@next[$level-1].map({ $_ ~ 'L' });
        @next[$level].push: |@mat[$level-1].map({ $_ ~ 'R' });
        @next[$level].push: |@mat[$level].map({ $_ ~ 'H' });
    }
    @mat = @next;
}

say "results: ", @mat[*-1].elems;;
.say for |@mat[*-1];

