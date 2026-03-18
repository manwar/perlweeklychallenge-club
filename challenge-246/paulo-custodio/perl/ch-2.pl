#!/usr/bin/env perl

# Perl Weekly Challenge 246 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/

use Modern::Perl;

my $ITERS = 10000;
my $MAX_VALUE = 10;

my @ints = @ARGV;
say found_solution(@ints) ? 'true' : 'false';

sub found_solution {
    my(@ints) = @_;
    my %seen;
    for (1..$ITERS) {
        my $p = input_value();
        my $q = input_value();
        next if $seen{$p}{$q}++;
        return 1 if is_linear_recurrence($p, $q, @ints);
    }
    return 0;
}

sub input_value {
    return int(rand()*2*$MAX_VALUE-$MAX_VALUE);
}

sub is_linear_recurrence {
    my($p, $q, @ints) = @_;
    for my $i (2..$#ints) {
        return 0 if $ints[$i] != $p * $ints[$i-2] + $q * $ints[$i-1];
    }
    return 1;
}
