#!/usr/bin/env perl
package challenge194::ch2;

use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce);

use Test::More tests => 3;

is( frequency_equalizer('abbc'),    1, "Example 1" );
is( frequency_equalizer('xyzyyxz'), 1, "Example 2" );
is( frequency_equalizer('xzxz'),    0, "Example 3" );

sub frequency_equalizer ($x) {
    my %frequencies;
    $frequencies{$_}++ for split( //, $x );

    my %frequency_frequencies;
    $frequency_frequencies{$_}++ for values %frequencies;

    return (
        keys %frequency_frequencies == 2
          && abs(
            reduce { $a - $b }
            keys %frequency_frequencies

          ) == 1
          && grep { $_ == 1 } values %frequency_frequencies
    ) ? 1 : 0;
}
