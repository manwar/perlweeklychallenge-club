#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;
use 5.022;

my $n = $ARGV[0];

say power_rep_true($n);

#
#
#
sub power_rep_true {
    my ($n) = @_;

    # As  N = (√N)² for all N positive integers, set a = √N and b = 2.
    # As it is not defined what to do if N is not a positive integer  - return 1 anyway.
    return 1;

}

