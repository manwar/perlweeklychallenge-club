#!/usr/bin/env perl
# Week 135 Task 1
# Middle 3 digits

use strict;
use warnings;
use feature qw/ say /;

my $input = $ARGV[0];
$input =~ s/^\-//;
my $input_length = length $input;

( $input_length % 2 ) != 0 or die "even number of digits\n";
$input_length >= 3 or die "too short\n";

say substr $input, ( $input_length / 2 ) - 1, 3;
