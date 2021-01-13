#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';
use FNR;

my @A = @ARGV;
my $fnr = FNR->new();

my $output = $fnr->from_string($A[0]);

print $output;
