#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my @examples = ( 10, 27, 85, 101 );

for my $e (@examples) {
    say join "\t", '', $e, isqrt1($e), isqrt2($e),;
}

# the way we're requested to not use, for demonstration
sub isqrt1 ($n) {
    return int sqrt $n;
}

# another way:
sub isqrt2 ($n) {
    my $j = 1;
    while (1) {
        return $j - 1 if $n < $j**2;
        $j++;
    }
    return 1;
}
