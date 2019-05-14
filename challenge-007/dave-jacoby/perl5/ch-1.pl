#!/usr/bin/env perl

use feature qw{ say };
use strict;
use warnings;

use List::Util qw{sum};

for my $i ( 1 .. 50 ) {
    my @j = split //, $i; # split the number into characters
    my $k = sum @j;       # Perl doesn't overload operators,
                          # but overloads types, so if you do
                          # a math operation on a scalar, it
                          # finds the most number-like
                          # interpretation of that scalar

    my $l = $i % $k == 0; # true if it divides evenly.
    say $i if $l;         # say if true
                          # we COULD combine these two
}

