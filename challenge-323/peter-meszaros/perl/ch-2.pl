#!/usr/bin/env perl
#
=head1 Task 2: Tax Amount

Submitted by: Mohammad Sajid Anwar

You are given an income amount and tax brackets.

Write a script to calculate the total tax amount.

=head2 Example 1

    Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
    Output: 1.65

    1st tax bracket upto  3, tax is 50%.
    2nd tax bracket upto  7, tax is 10%.
    3rd tax bracket upto 12, tax is 25%.

    Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
              => 1.50 + 0.40 + 0.75
              => 2.65

=head2 Example 2

    Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
    Output: 0.25

    Total Tax => (1 * 0/100) + (1 * 25/100)
              => 0 + 0.25
              => 0.25

=head2 Example 3

    Input: $income = 0, @tax = ([2, 50])
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[10, [[3, 50], [7, 10], [12,25]]], 2.65, "Example 1"],
    [[ 2, [[1, 0], [4, 25], [5,50]]],   0.25, "Example 2"],
    [[ 0, [[2, 50]]],                   0,    "Example 3"],
];

sub tax_amount
{
    my $income = $_[0]->[0];
    my $tax    = $_[0]->[1];

    my $total_tax = 0;
    my $last_limit = 0;
    for my $t (@$tax) {
        my $limit = $t->[0];
        my $rate  = $t->[1] / 100;

        last if $income <= $last_limit;

        if ($income > $limit) {
            $total_tax += ($limit - $last_limit) * $rate;
        } else {
            $total_tax += ($income - $last_limit) * $rate;
            last;
        }
        $last_limit = $limit;
    }

    return $total_tax;
}

for (@$cases) {
    is(tax_amount($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
