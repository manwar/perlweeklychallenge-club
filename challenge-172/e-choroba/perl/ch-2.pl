#! /usr/bin/perl
use warnings;
use strict;

use PDL;

sub five_number_summary {
    my ($data) = @_;
    return map pdl(@$data)->pctover($_), 0, 1/4, 0.5, 0.75, 1
}

use Test::More tests => 2;

# This test fails. PDL doesn't use a simple interpolation.
is_deeply [five_number_summary([0, 0, 1, 2, 63, 61, 27, 13])],
    [0, 0.5, 7.5, 44, 63];

# This is the actual result. It corresponds to R's summary() rather
# than fivenum().
is_deeply [five_number_summary([0, 0, 1, 2, 63, 61, 27, 13])],
    [0, 0.75, 7.5, 35.5, 63];
