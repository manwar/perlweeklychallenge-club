#! /opt/local/bin/perl
#
#       pyramid-power.pl
#
#         Triangle Sum
#         Submitted by: Mohammad S Anwar
#         You are given triangle array.
# 
#         Write a script to find the minimum path sum from top to bottom.
# 
#         When you are on index i on the current row then you may move to either index i or index i + 1 on the next row.
# 
#         Example 1:
#             Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
#             Output: 8
# 
#         Explanation: The given triangle
# 
#                     1
#                    2 4
#                   6 4 9
#                  5 1 7 2
# 
#         The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
# 
#                     [1]
#                   [2] 4
#                   6 [4] 9
#                  5 [1] 7 2
# 
#         Example 2:
#             Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
#             Output: 7
# 
#         Explanation: The given triangle
# 
#                     3
#                    3 1
#                   5 2 3
#                  4 3 1 3
# 
#         The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
# 
#                     [3]
#                    3  [1]
#                   5 [2] 3
#                  4 3 [1] 3
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub findpath ($arr) {
## the data structure: [ sum, [arr of values along path], last index ] 

    my $root = $arr->[0][0];
    my @data = [$root, [$root], 0];
    
    for my $depth ( 0..$#$arr-1 ) {
        for my $pos ( 0..2**$depth-1 ) {
            my $path = shift @data;
            for (0,1) {
                my ($sum, $trace, $last) = @$path;
                my $value = $arr->[$depth+1][$last+$_];
                my $newpath = [  $sum + $value,
                                 [$trace->@*, $value],
                                 $last + $_  ];
                push @data, $newpath;
            }
        }
    }
    
    my $minpath = (sort {$a->[0] <=> $b->[0]} @data)[0];
    
    say "minimum path sum: ", $minpath->[0];
    say "path:";
    say join ' -> ', $minpath->[1]->@*;

    return $minpath->[0];
}


use Test::More;

is findpath( [[1], [2,4], [6,4,9], [5,1,7,2]] ), 8, 'ex-1';
is findpath( [[3], [3,1], [5,2,3], [4,3,1,3]] ), 7, 'ex-2';



done_testing();
