#!/usr/bin/perl

use v5.26;
use warnings;

use PDL;
use PDL::LinearAlgebra;


### Input and Output

say olympic_rings();


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/26/ch-043.html#task-2

sub olympic_rings {
    my $a = pdl
        '1 0 0 1 0 0 0 0 0;
         0 1 0 0 1 1 0 0 0;
         0 0 1 0 0 0 1 0 0;
         0 0 0 1 1 0 0 1 0;
         0 0 0 0 0 1 1 0 1;
         1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 0 0;
         0 0 0 0 0 0 0 1 0;
         0 0 0 0 0 0 0 0 1';
    my $b = pdl '11 11 11 11 11 9 8 5 7';

    msolve($a, $b->dummy(0))->flat;
}
