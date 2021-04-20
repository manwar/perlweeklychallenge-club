#!/usr/bin/perl

# Perl Weekly Challenge - 109
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-109/#TASK1
#
# Task 1 - Chowla Numbers
#
#          C(n) = sum of divisors of n except 1 and n
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum0);

# Prototype(s)
sub chowlaNumber($);

my $N = shift @ARGV // 20;

printf "First %d Chowla numbers: %s\n",
       $N, join(',', map { chowlaNumber($_) } 1 .. $N);



sub chowlaNumber($) {
    my ($n) = @_;

    my @devisors = grep { $n % $_ == 0} 2 .. int($n/2);

    return sum0(@devisors);
}

