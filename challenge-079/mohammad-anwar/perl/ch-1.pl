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

my $N = $ARGV[0] || 4;
die "ERROR: Invalid number [$N].\n" unless ($N =~ /^\d+$/);
print count_set_bits($N), "\n";

#
#
# SUBROUTINE

sub count_set_bits {
    my $c = 0;
    $c   += (sprintf "%b", $_) =~ tr/1/1/ for 1..shift;
    return $c % 1000000007;
}
