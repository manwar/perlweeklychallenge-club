#!/usr/bin/env perl

# Perl Weekly Challenge 326 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @output;
while (my($count, $num) = splice(@ARGV, 0, 2)) {
    push @output, ($num) x $count;
}
say "(", join(", ", @output), ")";
