#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Set::Scalar;

# TASK #1 › Common Factors
# Submitted by: Niels van Dijke
#
# You are given 2 positive numbers $M and $N.
#
# Write a script to list all common factors of the given numbers.

my ($m, $n) = @ARGV;
local $, = ", ";
my $s1 = factors($m);
my $s2 = factors($n);
say $s1->intersection($s2);

sub factors($n) {
    my $s = Set::Scalar->new(1);
    for my $i (2..sqrt($n)) {
        $s->insert($i, $n / $i) if $n % $i == 0;
    }

    return $s;
}

