#!/usr/bin/perl
use warnings;
use strict;

use Math::Prime::Util qw{ factor gcd };

sub achilles_numbers {
    my ($tally) = @_;
    my $n = 1;
    my @achilles_numbers;
    while (@achilles_numbers < $tally) {
        my %factors;
        ++$factors{$_} for factor(++$n);
        next if grep $_ == 1, values %factors;  # Powerful.

        push @achilles_numbers, $n
            if 1 == gcd(values %factors);  # Not perfect.
    }
    return \@achilles_numbers
}

use Test::More tests => 1;
is_deeply achilles_numbers(20),
    [72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864,
     968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800];
