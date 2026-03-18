#!/usr/bin/env perl

# Perl Weekly Challenge 235 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/

use Modern::Perl;

my @ints = @ARGV;

say can_make_strict_increasing_order(@ints) ? "true" : "false";

sub can_make_strict_increasing_order {
    my(@ints) = @_;
    return 1 if !@ints;
    for my $i (0..$#ints) {
        return 1 if is_strict_increasing(@ints[0..$i-1], @ints[$i+1..$#ints]);
    }
    return 0;
}

sub is_strict_increasing {
    my(@ints) = @_;
    return 1 if !@ints;
    for my $i (1..$#ints) {
        return 0 if $ints[$i] <= $ints[$i-1];
    }
    return 1;
}
