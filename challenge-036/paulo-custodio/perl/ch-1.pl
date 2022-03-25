#!/usr/bin/env perl

# Challenge 036
#
# TASK #1
# Write a program to validate given Vehicle Identification Number (VIN).
# For more information, please checkout wikipedia.

use Modern::Perl;
use Data::Validate::VIN;

my $vin = shift;
my $vv = Data::Validate::VIN->new($vin);
say $vv->valid() ? 1 : 0;
