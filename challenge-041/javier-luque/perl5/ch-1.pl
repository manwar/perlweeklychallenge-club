#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use Math::Prime::Util qw /factor is_prime/;
use feature qw /say/;

for my $i (1..50) {
    my @factors = factor($i);
    say $i if (is_prime(scalar(@factors)));
}
