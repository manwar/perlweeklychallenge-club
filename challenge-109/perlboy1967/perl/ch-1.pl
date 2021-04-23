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

use Test::More;
use Test::Deep;

# Prototype(s)
sub chowlaNumber($);

cmp_deeply ([map {chowlaNumber($_)} 1 .. 20],
            [0,0,0,2,0,5,0,6,3,7,0,15,0,9,8,14,0,20,0,21]);

done_testing;


sub chowlaNumber($) {
    my ($n) = @_;

    my @devisors = grep { $n % $_ == 0} 2 .. int($n/2);

    return sum0(@devisors);
}

