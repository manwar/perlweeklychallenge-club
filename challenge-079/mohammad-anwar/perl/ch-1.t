#!/usr/bin/perl

#
# Perl Weekly Challenge - 079
#
# Task #1: Count Set Bits
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use strict;
use warnings;
use Test::More;

is(count_set_bits(4), 5, "testing example 1");
is(count_set_bits(3), 4, "testing example 2");

done_testing;

#
#
# SUBROUTINE

sub count_set_bits {
    my $c = 0;
    $c   += (sprintf "%b", $_) =~ tr/1/1/ for 1..shift;
    return $c % 1000000007;
}
