#!/usr/bin/env perl6
#
#
#       trip-from-the-line.raku
#
#       Basketball Points
#         Submitted by: Mohammad S Anwar
#         You are given a score $S.
# 
#         You can win basketball points e.g. 1 point, 2 points and 3 points.
# 
#         Write a script to find out the different ways you can score $S.
# 
#         Example
# 
#         Input: $S = 4
#         Output: 1 1 1 1
#                 1 1 2
#                 1 2 1
#                 1 3
#                 2 1 1
#                 2 2
#                 3 1
# 
#         Input: $S = 5
#         Output: 1 1 1 1 1
#                 1 1 1 2
#                 1 1 2 1
#                 1 1 3
#                 1 2 1 1
#                 1 2 2
#                 1 3 1
#                 2 1 1 1
#                 2 1 2
#                 2 2 1
#                 2 3
#                 3 1 1
#                 3 2
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $score = 5) ;

my @points = 1, 2, 3 ;
my @queue  = @points.grep( * <= $score )
                    .map(  *.Array ) ;
my @parts;

while @queue.shift -> @seq {
    for @points {
        my @new = |@seq, $_ ;
        next if @new.sum > $score;
        @new.sum == $score ?? @parts.push: @new
                           !! @queue.push: @new;
    }
}

put $_ for @parts;

