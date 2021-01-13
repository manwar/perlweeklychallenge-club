#! /opt/local/bin/perl
#
#       four_corners_off_a_twenty.pl
#
#         TASK #2 › Find Square
#         Submitted by: Mohammad S Anwar
#         You are given matrix of size m x n with only 1 and 0.
# 
#         Write a script to find the count of squares having all four corners
#         set as 1.
# 
#         Example 1:
#         Input: [ 0 1 0 1 ]
#                [ 0 0 1 0 ]
#                [ 1 1 0 1 ]
#                [ 1 0 0 1 ]
# 
#         Output: 1
#         Explanation:
#         There is one square (3x3) in the given matrix with four corners as 1
#         starts at r=1;c=2.
#         [ 1 0 1 ]
#         [ 0 1 0 ]
#         [ 1 0 1 ]

#         Example 2:
#         Input: [ 1 1 0 1 ]
#                [ 1 1 0 0 ]
#                [ 0 1 1 1 ]
#                [ 1 0 1 1 ]
# 
#         Output: 4
#         Explanation:
#         * There is one square (4x4) in the given matrix with four corners as 1
#         starts at r=1;c=1.
#         * There is one square (3x3) in the given matrix with four corners as 1
#         starts at r=1;c=2.
#         * There are two squares (2x2) in the given matrix with four corners as 1
#         First starts at r=1;c=1 and second starts at r=3;c=3.

#         Example 3:
#         Input: [ 0 1 0 1 ]
#                [ 1 0 1 0 ]
#                [ 0 1 0 0 ]
#                [ 1 0 0 1 ]
# 
#         Output: 0


#         method:
#             We need to methodically examine quads of points, each expressing
#             the four corners of an internal square. Each square in turn can be
#             expressed as a base corner closest to the origin and an edge size.
#             If all four corners are 1s, then we have a match and the square is
#             logged. The squares to be looked at range in size from edge length
#             2 to the shorter dimension of the enclosing matrix. Every square
#             group of a given size starts with the first instance in the upper
#             left corner at (0,0) and from there gets translated righwards and
#             down to map all possible placements. The number of repetions in
#             each direction will be the length of the matrix dimension minus
#             the square edge dimension.
# 
#             The number of squares to be evaluated is defined by the
#             sequence of the square pyrimidal numbers*, A00330 in the OEIS.
#             Using the formula for generating the n-th number in the
#             sequence 
#             
#                 a(n) = n*(n+1)*(2*n+1)/6
#             
#             As we are only considering squares of minimum edge length 2, 
#             the number of squares S contained within an (M x M) matrix is  
#             
#                 S = a(M-1)
# 
#             We walk through every point in the matrix, and if it's a 1 we can then 
#             check it for squares of increasing size until a dimension goes out of bounds.
#             This prunes evaluation of many squares immediately.
# 
#             
#           -----------------------------------------------------
#             *  OEIS A00330, Kristie Smith, Apr 16 2002


#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

our $squarecount = 0;

srand(1010);

my $r = 5 ;
my $c = 10;
my $matrix = [ map { [ map { int rand 2 == 0 ? 1 : 0 } (1..$c) ] } (1..$r) ] ;



say "@$_" for $matrix->@*;
say '';


my $cols = $matrix->[0]->@*;
my $rows = $matrix->@*;

my $min_dimension = $cols < $rows ? $cols : $rows;

my @output;

for my $c ( 0..$cols-2 ) {
    for my $r ( 0..$rows-2) {
        next unless $matrix->[$r][$c];
        for my $size ( 2..$min_dimension ) {            ## for each square size group
            last if $c + $size > $cols || $r + $size > $rows;
            if (four_corners($r, $c, $size, $matrix)) {
                push @output, [ $r, $c, $size ];
            }
        }
    }
}

# say "square at row $_->[0] column $_->[1] with size $_->[2]" for @output;
say "found ", scalar @output,  " squares:";

for my $s ( sort { $a->[2] <=> $b->[2] } @output ) {
    printf "column %d row %d from top - square of size %d \n", $s->[1]+1, $s->[0]+1, $s->[2];
}

say "\nevaluated $squarecount squares";

## ## ## ## ## SUBS:

sub four_corners {
    $squarecount++;

    my ($r, $c, $size, $matrix) = @_;
    $size--;
    
    ## short-circuits out
    return 1 if     $matrix->[$r][$c]             == 1
                 && $matrix->[$r][$c+$size]       == 1
                 && $matrix->[$r+$size][$c]       == 1
                 && $matrix->[$r+$size][$c+$size] == 1 ;
    return 0;
}

