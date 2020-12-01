#! /opt/local/bin/perl
#
#       spiral.pl
#
#       TASK #2 › Spiral Matrix
#         Submitted by: Mohammad S Anwar
#         You are given m x n matrix of positive integers.
#
#         Write a script to print spiral matrix as list.
#
#         Example 1:
#             Input:
#                 [ 1, 2, 3 ]
#                 [ 4, 5, 6 ]
#                 [ 7, 8, 9 ]
#             Ouput:
#                 [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]
#
#         Example 2:
#             Input:
#                 [  1,  2,  3,  4 ]
#                 [  5,  6,  7,  8 ]
#                 [  9, 10, 11, 12 ]
#                 [ 13, 14, 15, 16 ]
#             Output:
#                 [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use POSIX qw( ceil floor );

## ## ## ## ## MAIN:
my $mat;
$mat = [ [1,2,3,4], [5,6,7,8], [9,10,11,12] ];
# $mat = [ [1,2,3], [4,5,6], [7,8,9], [10,11,12], [13,14,15] ];
# $mat = [ [1], [2], [3], [4] ];
# $mat = [ [1,2,3,4] ];
# $mat = [
#     [ 1, 2, 3, 4, 5, 6],
#     [ 7, 8, 9,10,11,12],
#     [13,14,15,16,17,18],
#     [19,20,21,22,23,24],
#     [25,26,27,28,29,30]
# ];

my @out = spiralize($mat)->@*;

say "@out";

## ## ## ## ## SUBS:

sub spiralize {
    my ($mat) = @_;
    my $cols  = $mat->[0]->@*;
    my $rows  = $mat->@*;
    my $rank  = 0;           ## loop count of spiral, 0-based
    my $out   = [];

    while (-spiraling) {
        ## upper - left to right
        return $out if $rank > ceil( $rows / 2 - 1);
        push $out->@*, $mat->[$rank]->@[$rank..$cols-$rank-1];

        ## right - top to bottom
        return $out if $rank > ceil( $cols / 2 - 1);
        for my $row ( $rank+1..$rows-$rank-2 ) {
            push $out->@*, $mat->[$row][$cols-$rank-1];
        }

        ## lower - right to left
        return $out if $rank > floor( $rows / 2 - 1);
        push $out->@*, reverse $mat->[$rows-$rank-1]->@[$rank..$cols-$rank-1] ;

        ## left - bottom to top
        return $out if $rank > floor( $cols / 2 - 1);
        for my $row ( reverse $rank+1..$rows-$rank-2 ) {
            push $out->@*, $mat->[$row][$rank];
        }
        $rank++
    }
}
