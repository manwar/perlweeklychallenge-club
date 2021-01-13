#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use bignum;

sub TruncNum { 1000000007 } # spec
sub usage {
    say "perl ch-1.pl <N> # where N is positive integer";
}

BEGIN {
    eval { defined $ARGV[0] and $ARGV[0] > 0 or die "invalid" };
    $@ and usage(), exit 0;
}

package older;
use List::Util qw(sum);

sub sumSection ($) {  # sum of the counts of bits between 2^(m) .. 2^(m+1)-1
    state @K = (1, 3);
    my $m = shift;

    exists $K[$m] ? $K[$m] : ( $K[$m] = sum( 1<<$m, @K[0..$m-1] ) );
}

sub sumUptoPow2 ($) { # sum of bits between 0 .. 2^pow
    sum 1, # sumSection doesn't count the last bits of 2^pow
      map { sumSection $_ } 0 .. $_[0]-1
}

package main;

# there is a simpler way to calculate, which I realised today.
# but this method is not significantly faster than previous one.
sub sumUptoPow2 ($) {
    my $pow = shift;
    ( $pow * (1 << $pow) >> 1 ) + 1;  # eqv. ($pow * (2**$pow) / 2 ) + 1;
}

sub countSetBits ($);
sub countSetBits ($) {
    $_[0] <= 2 and return $_[0];
    my $N = shift;

    my $N1 = $N;

    my ( $sum, $pow );
    ++$pow while ( $N1 >>= 1 );

    $N1 = $N - (1<<$pow);

    $sum += sumUptoPow2 $pow;
    $N1 == 0 ? $sum : ( $sum
                       + $N1 # the number ( 1..$N1 ) always has one set bit
                       + countSetBits($N1)    # count without first set bit
                     );
    # go recursive until meets 0<= N <= 2
}

say( countSetBits(shift) % TruncNum );
