#!/usr/bin/perl
use warnings;
use strict;

sub dot_product {
    my ($A, $B) = @_;
    my $sum = 0;
    for my $i (0 .. $#$A) {
        $sum += $A->[$i] * $B->[$i];
    }
    return $sum
}

use Test2::V0;
plan 1;

my @a = (1, 2, 3);
my @b = (4, 5, 6);
is dot_product(\@a, \@b), 32, 'Example 1';
