#!/usr/bin/env perl6

# skeleton.p6 - Rotate Matrix
#
# Ryan Thompson <rjt@cpan.org>

sub transpose(@A) { [Z] @A }

multi sub rotate-cw(@A) { [Z] @A.reverse }
multi sub rotate-cw(@A where !*[0].isa("List")) { @A.map: { [$_] } }

sub rotate180(@A)    { rotate-cw( rotate-cw(@A) ) }
sub rotate-ccw(@A)   { rotate180( rotate-cw(@A) ) }


#
# Tests
# 

use Test;

# Matrix transposition
is-deeply transpose((1,2,3; 4,5,6; 7,8,9)), (1,4,7; 2,5,8; 3,6,9);

# Rotation (mirrored transpose)
is-deeply rotate-cw( (1,2,3; 4,5,6; 7,8,9)), (7,4,1; 8,5,2; 9,6,3);
is-deeply rotate180((1,2,3; 4,5,6; 7,8,9)), (9,8,7; 6,5,4; 3,2,1);
is-deeply rotate-ccw((1,2,3; 4,5,6; 7,8,9)), (3,6,9; 2,5,8; 1,4,7);

# MxN
is-deeply rotate-cw((1,2; 3,4; 5,6)), (5,3,1; 6,4,2);
is-deeply rotate180((1,2; 3,4; 5,6)), (6,5; 4,3; 2,1);

# 1xN, Nx1
is-deeply rotate-cw((1,2,3)), ([1],[2],[3]);
is-deeply rotate-cw([ [1],[2],[3] ]), ((3,2,1),);

# Non-numeric, because why not
is-deeply rotate-cw(('a','b','c'; 'd','e','f')), ('d','a'; 'e','b'; 'f','c');
