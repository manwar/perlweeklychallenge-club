#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub maximum_frequency(@ints) {
    my %freq;
    ++$freq{$_} for @ints;
    my %freq_freq;
    ++$freq_freq{$_} for values %freq;
    my $max_freq = max(keys %freq_freq);
    return $freq_freq{$max_freq} * $max_freq
}

use Test::More tests => 2 + 1;

is maximum_frequency(1, 2, 2, 4, 1, 5), 4, 'Example 1';
is maximum_frequency(1, 2, 3, 4, 5), 5, 'Example 2';

is maximum_frequency((1 .. 3) x 4), 12, '3x4';
