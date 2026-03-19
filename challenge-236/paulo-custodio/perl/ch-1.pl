#!/usr/bin/env perl

# Perl Weekly Challenge 236 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-236/

use Modern::Perl;

my $PRICE = 5;

my @customers = @ARGV;
say is_exact_change(@customers) ? "true" : "false";

sub is_exact_change {
    my(@customers) = @_;
    my @bills;
    while (@customers) {
        my $received = shift @customers;
        $bills[$received]++;
        my $change = $received - $PRICE;
        while ($change != 0) {
            my $found;
            for my $bill (reverse 0..$#bills) {
                if (defined($bills[$bill]) && $change >= $bill && $bills[$bill] > 0) {
                    $bills[$bill]--;
                    $change -= $bill;
                    $found = 1;
                    last;
                }
            }
            next if $found;
            return 0;       # not possible to give correct change
        }
    }
    return 1;
}
