#!/usr/bin/perl

#
# Perl Weekly Challenge - 077
#
# Task #1: Fibonacci Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077
#

use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);

my $N = $ARGV[0];

print "USAGE: perl $0 <positive_number>\n" and exit
    unless (defined $N && $N > 0);
p(fibonacci_sum(fibonacci_series_upto($N), $N));

#
#
# METHODS

sub p {
    my ($fibonacci_sum) = @_;

    foreach (@$fibonacci_sum) {
        print sprintf("%s\n", join ", ", @$_);
    }
}

sub fibonacci_sum {
    my ($fibonacci, $sum) = @_;

    my $fibonacci_sum = [];
    foreach my $i (1 .. $sum) {
        last if ($i > @$fibonacci);
        foreach my $comb (combinations($fibonacci, $i)) {
            my $_sum = 0;
            $_sum += $_ for @$comb;
            push @$fibonacci_sum, $comb if ($_sum == $sum);
        }
    }

    return $fibonacci_sum;
}

sub fibonacci_series_upto {
    my ($num) = @_;

    my @fibonacci = (1, 2);
    while ($fibonacci[-1] + $fibonacci[-2] <= $num) {
        push @fibonacci, ($fibonacci[-1] + $fibonacci[-2]);
    }

    return \@fibonacci;
}
