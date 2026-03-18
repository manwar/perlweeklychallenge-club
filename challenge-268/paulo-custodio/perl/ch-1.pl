#!/usr/bin/env perl

# Perl Weekly Challenge 268 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/

use Modern::Perl;

my($x, $y) = split /,/, "@ARGV";
my @x = split ' ', $x;
my @y = split ' ', $y;

say magic_number(\@x, \@y);

sub magic_number {
    my($x, $y) = @_;

    my @x = sort {$a <=> $b} @$x;
    my @y = sort {$a <=> $b} @$y;

    return -1 if scalar(@x) != scalar(@y);

    my $delta = $y[0]-$x[0];
    for (0 .. $#x) {
        return -1 if $y[$_]-$x[$_] != $delta;
    }
    return $delta;
}
