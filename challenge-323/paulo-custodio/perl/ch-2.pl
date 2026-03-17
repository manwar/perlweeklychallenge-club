#!/usr/bin/env perl

# Perl Weekly Challenge 323 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/

use Modern::Perl;
use List::Util qw(min);

chomp(my $income = <>);
my @tax;
while (<>) {
    push @tax, [split ' ', $_];
}
say compute_tax($income, @tax);

sub compute_tax {
    my($income, @tax) = @_;
    my $tax = 0;
    my $base = 0;
    while (@tax && $income > $base) {
        my $taxable = min($income - $base, $tax[0][0] - $base);
        $tax += $taxable * $tax[0][1] / 100;
        $base = $tax[0][0];
        shift @tax;
    }
    return $tax;
}
