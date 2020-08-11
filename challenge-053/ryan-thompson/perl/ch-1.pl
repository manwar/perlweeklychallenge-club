#!/usr/bin/env perl
#
# ch-1.pl - Rotate matrix
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# Rotate a matrix clockwise
sub rotate90_cw {
    my @A = reverse @{$_[0]};
    my @T;
    for my $x (0..$#A) {
        $T[$_][$x] = $A[$x][$_] for 0..$#{$A[0]};
    }
    \@T;
}

# Convenience
sub rotate180    { rotate90_cw( rotate90_cw (@_) ) }
sub rotate_ccw   { rotate90_cw( rotate180(   @_) ) }

#
# Tests
#
use Test::More;

# 3x3
is_deeply rotate90_cw ( [[1,2,3],[4,5,6],[7,8,9]]), [[7,4,1],[8,5,2],[9,6,3]];
is_deeply rotate180(    [[1,2,3],[4,5,6],[7,8,9]]), [[9,8,7],[6,5,4],[3,2,1]];
is_deeply rotate_ccw(   [[1,2,3],[4,5,6],[7,8,9]]), [[3,6,9],[2,5,8],[1,4,7]];

# MxN
is_deeply rotate90_cw ( [[1,2],[3,4],[5,6]]), [[5,3,1],[6,4,2]];
is_deeply rotate180(    [[1,2],[3,4],[5,6]]), [[6,5],[4,3],[2,1]];

# 1xN, Nx1
is_deeply rotate90_cw(  [[1,2,3]]),     [[1],[2],[3]];
is_deeply rotate90_cw(  [[1],[2],[3]]), [[3,2,1]];

# Non-numeric, because why not
is_deeply rotate90_cw ( [['a','b','c'],  ['d','e','f']] ), 
                        [['d','a'],['e','b'],['f','c']];

done_testing;
