#!perl

use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub rotate {
    my @A = (7, 4, 2, 6, 3);
    my @B = (1, 3, 4);    
    for my $rot (@B) {
        say join q(, ), map { $A[($_ + $rot) % @A] } 0 .. @A - 1;
    }
}

rotate();