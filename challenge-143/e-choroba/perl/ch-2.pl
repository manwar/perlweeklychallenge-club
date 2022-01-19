#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub stealthy_number {
    my ($n) = @_;
    my @divisors = (map $n / $_, grep 0 == $n % $_, 1 .. sqrt $n);
    for my $A (@divisors) {
        for my $C (@divisors) {
            my $B = $n / $A;
            my $D = $n / $C;
            return 1 if $A + $B == $C + $D + 1;
        }
    }
    return 0
}

use Test2::V0;
plan 3;

is stealthy_number(36), 1, 'Example 1';
is stealthy_number(12), 1, 'Example 2';
is stealthy_number(6), 0, 'Example 3';
