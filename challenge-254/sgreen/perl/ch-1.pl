#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Math::Round 'round';

sub three_power ($n) {
    # Get the closest integer to a cube root
    my $i = round(abs($n) ** (1/3));

    # Return true if this number is indeed a cube root
    return $i ** 3 == abs($n);
}

my $r = three_power($ARGV[0]);
say $r ? 'true' : 'false';