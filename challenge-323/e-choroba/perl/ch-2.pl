#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub tax_amount($income, @tax) {
    @tax = sort { $a->[0] <=> $b->[0] } @tax;
    my $from = 0;
    my $tax_total = 0;
    while (@tax && $from <= $income) {
        my ($bracket, $percent) = @{ shift @tax };
        my $to = $bracket < $income ? $bracket : $income;
        my $part = $to - $from;
        $tax_total += $part * $percent / 100;
        $from = $bracket;
    }
    return $tax_total
}

use Test2::V0;
plan(3 + 3);

is tax_amount(10, [3, 50], [7, 10], [12, 25]), 2.65, 'Example 1';
is tax_amount(2, [1, 0], [4, 25], [5, 50]), 0.25, 'Example 2';
is tax_amount(0, [2, 50]), 0, 'Example 3';

is tax_amount(10, [7, 10], [12,25], [3, 50], ), 2.65, 'Unsorted';
is tax_amount(10, [0, 100]), 0, 'Bracket 0';
is tax_amount(100, [10, 10], [50, 20]), 9, 'Largest bracket < income';
