#!/usr/bin/perl

#
# Perl Weekly Challenge - 072
#
# Task #1: Trailing Zeroes
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
#

package TrailingZeroes;

use Moo;

sub count {
    my ($self, $n) = @_;

    die "ERROR: Missing number.\n"
        unless defined $n;
    die "ERROR: Invalid number (<= 10).\n"
        if (($n <= 0) || ($n > 10));

    # generate factorial
    $n *= $_ for 1..$n-1;

    # count trailing zeroes
    $n =~ m/[1-9]?([0]+)$/;

    return (defined $1)?(length($1)):(0);
}

package main;

use strict;
use warnings;

use Test2::V0 -target => 'TrailingZeroes';

my %test_cases = (
    10 => 2,
     9 => 1,
     8 => 1,
     7 => 1,
     6 => 1,
     5 => 1,
     4 => 0,
     3 => 0,
     2 => 0,
     1 => 0,
);

foreach my $n (sort { $a <=> $b } keys %test_cases) {
    is $CLASS->count($n), $test_cases{$n}, "testing \$N=$n";
}

done_testing;
