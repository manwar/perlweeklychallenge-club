#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ say };

# Write a script that computes the equal point in the
# Fahrenheit and Celsius scales, knowing that the
# freezing point of water is 32 °F and 0 °C,
# and that the boiling point of water is 212 °F and 100 °C.
# This challenge was proposed by Laurent Rosenfeld.

# 32  F == 0 C -> F' = F - 32
# 100 C == 212F == 180F'
# 5   C == 9 F'
# Therefore, C = ( 5/9 ( F - 32 ) )
# And        F = 32 + ( 9/5 C )

# We're talking computing, so brute force is allowed

my $c  = -39;   # we COULD start at 0, but I know the answer...
my $f  = 32;    # I need $f > $c at this point, but we could do while...

while ( $c < $f ) {
    $c -= 0.1;
    $f  = 32 + ( $c * 9 / 5 );
}

say qq{$c °C == $f °F };

