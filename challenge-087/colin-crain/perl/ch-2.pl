#! /opt/local/bin/perl
#
#       largest_rectangle.pl
#
#         TASK #2 › Largest Rectangle
#         Submitted by: Mohammad S Anwar
#         You are given matrix m x n with 0 and 1.
#
#         Write a script to find the largest rectangle containing only 1. Print 0 if none found.
#
#         Example 1:
#         Input:
#             [ 0 0 0 1 0 0 ]
#             [ 1 1 1 0 0 0 ]
#             [ 0 0 1 0 0 1 ]
#             [ 1 1 1 1 1 0 ]
#             [ 1 1 1 1 1 0 ]
#
#         Output:
#             [ 1 1 1 1 1 ]
#             [ 1 1 1 1 1 ]
#         Example 2:
#         Input:
#             [ 1 0 1 0 1 0 ]
#             [ 0 1 0 1 0 1 ]
#             [ 1 0 1 0 1 0 ]
#             [ 0 1 0 1 0 1 ]
#
#         Output: 0
#         Example 3:
#         Input:
#             [ 0 0 0 1 1 1 ]
#             [ 1 1 1 1 1 1 ]
#             [ 0 0 1 0 0 1 ]
#             [ 0 0 1 1 1 1 ]
#             [ 0 0 1 1 1 1 ]
#
#         Output:
#             [ 1 1 1 1 ]
#             [ 1 1 1 1 ]
#
#         method:
#             we need to clarify and make some assumptions about the task: what is the minimum dimension
#             for a rectangle? Perhaps a string of 1s would make a rectangle, 11111, but were that
#             to be the case then 1 would be a valid 1x1 rectangle and that is precluded by the
#             second example. So it looks like the minimum dimension must be two, and we disallow
#             a trivial row or column segment of 1s.
#


#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

# my $matrix = [  [ 0, 0, 0, 1, 1, 1 ],
#                 [ 1, 1, 1, 1, 1, 1 ],
#                 [ 0, 0, 1, 0, 0, 1 ],
#                 [ 0, 0, 1, 1, 1, 1 ],
#                 [ 0, 0, 1, 1, 1, 1 ]  ] ;


# my $matrix = [  [ 0, 0, 0, 1, 0, 0 ],
#                 [ 1, 1, 1, 0, 0, 0 ],
#                 [ 0, 0, 1, 0, 0, 1 ],
#                 [ 1, 1, 1, 1, 1, 0 ],
#                 [ 1, 1, 1, 1, 1, 0 ]  ];

## create a random 10x10 matrix and display it
my $matrix = [ map { [ map { int rand 4 == 0 ? 0 : 1 } (1..10) ] } (1..10) ] ;
say "@$_" for $matrix->@*;
say '';


my $cols = $matrix->[0]->@*;
my $rows = $matrix->@*;
my @runs;
my @max = (0);

## parse matrix and construct data structure
## array index on matrix rows, with hashes as elements of unique keys
## pointing to index pair arrays
for my $r ( 0..$rows-1) {
   for my $c1 ( 0..$cols-2 ) {
        next unless $matrix->[$r][$c1] == 1;
        my $c2 = $c1 + 1;
        while  ($matrix->[$r][$c2] == 1) {
            $runs[$r]->{"${c1}_$c2"} = [$c1, $c2];
            last if ++$c2 > $cols - 1;
        }
    }
}

for my $r ( 0..$#runs ) {
    for my $run ( keys $runs[$r]->%* ) {
        my $n = 1;
        while (exists $runs[$r+$n]->{$run}) {
            $n++;
        }
        if ($n > 1) {
            my @arr = $runs[$r]->{$run}->@*;
            my $size = ( $arr[1] - $arr[0] + 1 ) * $n;
            $size > $max[0] and @max = ($size, @arr, $n);
        }
    }
}

# say "maximum rectangle @max";

## report
my ($size, $start, $end, $height) = @max;

$size == 0 and do { say 0; exit };

my $length = $end - $start + 1;
my @out = ('[', ('1') x $length, ']');
say "@out" for (1..$height);





## ## ## ## ## SUBS:

