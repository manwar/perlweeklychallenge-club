#!/usr/bin/perl

#
# Perl Weekly Challenge - 070
#
# Task #1: Character Swapping
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
#

use strict;
use warnings;

my $S = $ARGV[0] || 'perlandraku';
my $C = $ARGV[1] || 3;
my $O = $ARGV[2] || 4;

print sprintf("%s => %s\n", $S, swap($S, $C, $O));

sub swap {
    my ($string, $count, $offset) = @_;

    my $length = length($string);
    my @array  = split //, $string;
    foreach my $i (1..$count) {
        my $a = $i % $length;
        my $b = ($i + $offset) % $length;
        ($array[$a], $array[$b]) = ($array[$b], $array[$a]);
    }

    return join '', @array;
}
