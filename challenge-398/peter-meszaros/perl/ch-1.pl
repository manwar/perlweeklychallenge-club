#!/usr/bin/env perl
#
=head1 Task 1: Divisible Average

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers.  Write a script to return the
closest integer to the mean value of all even integers that are divisible by 3.
If none is divisible, return 0.

=head2 Example 1

    Input: @arr = (18, 5, 7, 11)
    Output: 18

    18 is the only even number and divisible by 3.
    Average: 18 / 1 = 18.

=head2 Example 2

    Input: @arr = (6, 12, 18, 24, 30, 40)
    Output: 18

    The qualifying numbers are 6, 12, 18, 24, and 30.
    Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18

=head2 Example 3

    Input: @arr = (3, 9, 15, 21, 27)
    Output: 0

    None of the elements are even.
    Since no elements qualify, return 0.

=head2 Example 4

    Input: @arr = (6, 12, 14, 20)
    Output: 9

    The qualifying numbers are 6 and 12.
    Average: (6 + 12) / 2 = 9.

=head2 Example 5

    Input: @arr = (6, 6, 6, 12, 12)
    Output: 8

    All five numbers are even and divisible by 3.
    Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {arr => [18, 5, 7, 11],          out => 18, name => 'Example 1'},
    {arr => [6, 12, 18, 24, 30, 40], out => 18, name => 'Example 2'},
    {arr => [3, 9, 15, 21, 27],      out =>  0, name => 'Example 3'},
    {arr => [6, 12, 14, 20],         out =>  9, name => 'Example 4'},
    {arr => [6, 6, 6, 12, 12],       out =>  8, name => 'Example 5'},
);

sub divisible_average
{
    my $arr = shift;

    my @filtered = grep { $_ % 2 == 0 && $_ % 3 == 0 } @$arr;
    return 0 unless @filtered;
    my $sum = 0;
    $sum += $_ for @filtered;
    return int($sum / @filtered + 0.5);
}

for my $case (@cases) {
    my $got = divisible_average($case->{arr});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
