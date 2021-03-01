#! /opt/local/bin/perl
#
#       sprialling-out-of-control.pl
# 
#             PWC 101
#             TASK #1 › Pack a Spiral
# 
#             Submitted by: Stuart Little
#             You are given an array @A of items (integers say, but they can be
#             anything).
#     
#             Your task is to pack that array into an MxN matrix spirally
#             counterclockwise, as tightly as possible.
#     
#             ‘Tightly’ means the absolute value |M-N| of the difference has to
#             be as small as possible.
#     
#             Example 1:
#             Input: @A = (1,2,3,4)
#     
#             Output:
#     
#                 4 3
#                 1 2
#     
#             Since the given array is already a 1x4 matrix on its own, but
#             that's not as tight as possible. Instead, you'd spiral it
#             counterclockwise into
#     
#                 4 3
#                 1 2
#             Example 2:
#             Input: @A = (1..6)
#     
#             Output:
#     
#                 6 5 4
#                 1 2 3
#     
#             or
#     
#                 5 4
#                 6 3
#                 1 2
#     
#             Either will do as an answer, because they're equally tight.

#         method:
#             Given an array, there will always be one packing available, 1 x n,
#             the linear form of the array itself. Beyond that, a tighter
#             packing would have to contain the correct number of elements
#             before any spiralling can commence.
# 
#             THus the first course of action is to compute the ideal
#             2-dimensional form from those avaailable.
# 
#             The absolute ideal two dimensional orthogonal packing would be a
#             square, so that (m-n) would be 0. Unfortunately this is only
#             available to arrays with lengths in the square numbers,
#             1,4,9,16,25,36 etc. 

#             In a general sense the dimensions of our rectangle, our
#             2-dimensional matrix, will be composed of two integers such that m
#             x n = L, the length of the original array to be spiralized. As our
#             ideal is a square form, the ideal dimension is the square root of
#             L, and any divergence from that ideal will expand the gap between
#             m and n. Thus by finding the smallest factor of L less than the
#             square root we will locate m, and from that we can determine n.
# 
#             Once we have our dimensions determined, we can commence rotation
#             and scalar reduction. 
#             
#             
#         conclusions and deep structure:
#             For testing we will make arrays from 1 to 100 items items long and
#             test them all. The actual values of the elements is
#             inconsequential so we will use sequentail values starting at 1;
#             this will make it easy to observe the spiralling. 

#             The observed pattern of minimized rectangular ratio, hence
#             minimizing abs(m-n) is:
# 
#             2,0,4,1,6,2,0,3,10,1,12,5,2,0,16,3,18,1,4,9,22,2,0,11,6,3,28...

#             from The On-Line Encyclopedia of Integer Sequences
#             2,0,4,1,6,2,0,3,10,1,12,5,2,0,16,3,18,1,4,9,22,2,0,11,6,3,28 
#             A056737		
#             Minimum nonnegative integer m such that n = k*(k+m) for some
#             positive integer k.


#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use POSIX;
use List::Util qw(max);


my @arr;
for my $n (3..100) {
    @arr = (1..$n);
    my ($m, $n) =  find_dim( scalar @arr );
    my $spiral = spiral_fill( $m, $n, @arr );
    print_matrix( $spiral );
    say '';

}

sub find_dim ($size) {
## SV Int size -> (SV Int m, SV Int n)
## find the largest factor less than or equal to the square root
    my $try = (int sqrt $size) + 1;
    while (--$try > 1) {
        last unless $size % $try;
    }
    return ($try, int $size/$try);
}

sub spiral_fill ( $rows, $cols, @arr ) {
## given dimensions and an array spiral fills a matrix with those dimensions
    my $rank = 0;
    my $mat;

    while ( -spiralize ) {
        ## lower - left to right
        return $mat if $rank > ceil( $rows / 2 - 1);
        for my $col ( $rank..$cols - $rank - 1) {
            $mat->[$rows-$rank-1][$col] = shift @arr;
        }

        ## right - bottom to top
        return $mat if $rank > ceil( $cols / 2 - 1);
        for my $row ( reverse $rank+1..$rows-$rank-2 ) {
            $mat->[$row][$cols-$rank-1] =  shift @arr;
        }

        ## upper - right to left
        return $mat if $rank > floor( $rows / 2 - 1);
        for my $col ( reverse $rank..$cols - $rank - 1) {
            $mat->[$rank][$col] =  shift @arr;
        }

        ## left - top to bottom
        return $mat if $rank > floor( $cols / 2 - 1);
        for my $row ( $rank+1..$rows-$rank-2 ) {
            $mat->[$row][$rank] =  shift @arr;
        }
        
        ## close ranks
        $rank++;
    }
}

sub print_matrix ( $matrix ) {

    if (scalar $matrix->@* == 1) {
        say "$_->@*" for $matrix->@*;
    }
    else {
        my @maxes = map { max $_->@* }  $matrix->@*;
        my $max = max @maxes;

        my $order = 0;
        $order++ while int($max/10**$order) > 0;
        $order+=2;              ## padding
        
        my $fmt = ("%-" . $order . "d") x scalar $matrix->[0]->@*;
        for (keys $matrix->@*) {
            printf "$fmt\n", $matrix->[$_]->@*;
        }
    
    }
    
}




