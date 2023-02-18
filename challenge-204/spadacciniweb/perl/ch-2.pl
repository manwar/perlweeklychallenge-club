#!/usr/bin/env perl

# Task 2: Reshape Matrix
# Submitted by: Mohammad S Anwar
# 
# You are given a matrix (m x n) and two integers (r) and (c).
# Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.
# 
# Example 1
# Input: [ 1 2 ]
#        [ 3 4 ]
#        $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
#        $r = 1
#        $c = 4
#
# Output: [ 1 2 3 4 ]
# 
# Example 2
# Input: [ 1 2 3 ]
#        [ 4 5 6 ]
# 
#        $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
#        $r = 3
#        $c = 2
# 
# Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
#         [ 1 2 ]
#         [ 3 4 ]
#         [ 5 6 ]
# 
# Example 3
# Input: [ 1 2 ]
#        $matrix = [ [ 1, 2 ] ]
#        $r = 3
#        $c = 2
# 
# Output: 0


use strict;
use warnings;
use PDL;

weak_reshape([ [ 1, 2 ], [ 3, 4 ] ], 1, 4);
weak_reshape([ [ 1, 2, 3 ] , [ 4, 5, 6 ] ], 3, 2);
weak_reshape([ [ 1, 2 ] ], 3, 2);

exit 0;

sub weak_reshape {
    my $matrix = pdl shift;
    my $r = shift;
    my $c = shift;

    print "Input matrix: ", $matrix;
    printf "reshaping %dx%d: ", $r, $c;
    if ($matrix->nelem == $r*$c) {
        print $matrix = reshape($matrix, $c, $r);
    } else {
        print 0, "\n";
    }
    print "\n";
}
