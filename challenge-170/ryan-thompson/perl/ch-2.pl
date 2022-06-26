#!/usr/bin/env perl
#
# ch-2.pl - Kronecker Product
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# Implementing the requested specific 2x2 case,
# but both subs work with arbitrary matrices.
pp_matrix(kronecker([[1,2],[3,4]], [[5,6],[7,8]]));

# Two AoA refs ($A, $B) as arguments, and the Kronecker product
# of A and B will be returned as an array of array refs.
sub kronecker {
    my ($A, $B) = @_;

    map {
        my $i = $_;
        [
            map { 
                    my    $aval = $_;
                    map { $aval * $_ } $B->[$i % @$B]->@*;
            } $A->[$i / @$B]->@*
        ]
    } 0..(@$A * @$B)-1;
}

# Pretty print a matrix as returned by kronecker()
sub pp_matrix {
    print '[ ' . join(' ', map { sprintf '%3d', $_ } @$_). " ]\n" for @_
}
