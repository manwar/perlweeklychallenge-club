#!/usr/bin/perl
use warnings;
use strict;

use PDL;
use PDL::GSLSF::GAMMA;

sub gamma {
    unpdl((gsl_sf_gamma(shift))[0])->[0]
}

use Test2::V0 qw{ is plan within };
plan 3;

my $TOLERANCE = 0.0100000000001;

is gamma(3), within(1.99, $TOLERANCE);
is gamma(5), within(24);
is gamma(7), within(719.99, $TOLERANCE);
