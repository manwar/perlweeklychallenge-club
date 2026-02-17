#!/usr/bin/env perl
#
=head1 Task 2: Date Difference

Submitted by: Mohammad S Anwar

You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.  Write a
script to find the difference between the given dates in terms on years and
days only.

=head2 Example 1

    Input: $date1 = '2019-02-10'
           $date2 = '2022-11-01'
    Output: 3 years 264 days

=head2 Example 2

    Input: $date1 = '2020-09-15'
           $date2 = '2022-03-29'
    Output: 1 year 195 days

=head2 Example 3

    Input: $date1 = '2019-12-31'
           $date2 = '2020-01-01'
    Output: 1 day

=head2 Example 4

    Input: $date1 = '2019-12-01'
           $date2 = '2019-12-31'
    Output: 30 days

=head2 Example 5

    Input: $date1 = '2019-12-31'
           $date2 = '2020-12-31'
    Output: 1 year

=head2 Example 6

    Input: $date1 = '2019-12-31'
           $date2 = '2021-12-31'
    Output: 2 years

=head2 Example 7

    Input: $date1 = '2020-09-15'
           $date2 = '2021-09-16'
    Output: 1 year 1 day

=head2 Example 8

    Input: $date1 = '2019-09-15'
           $date2 = '2021-09-16'
    Output: 2 years 1 day

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Date::Calc qw/N_Delta_YMD Delta_Days/;

my $cases = [
    [['2019-02-10', '2022-11-01'], '3 years 264 days', "Example 1"],
    [['2020-09-15', '2022-03-29'],  '1 year 195 days', "Example 2"],
    [['2019-12-31', '2020-01-01'],            '1 day', "Example 3"],
    [['2019-12-01', '2019-12-31'],          '30 days', "Example 4"],
    [['2019-12-31', '2020-12-31'],           '1 year', "Example 5"],
    [['2019-12-31', '2021-12-31'],          '2 years', "Example 6"],
    [['2020-09-15', '2021-09-16'],     '1 year 1 day', "Example 7"],
    [['2019-09-15', '2021-09-16'],    '2 years 1 day', "Example 8"],
    [['2020-11-28', '2020-11-28'],            '0 day', "Example 9"],
];

sub  date_difference
{
    my $date1 = $_[0]->[0];
    my $date2 = $_[0]->[1];

    my @d1 = split /-/, $date1;
    my @d2 = split /-/, $date2;

    my ($y) = N_Delta_YMD(@d1, @d2);
    my $years = $y;
    $d1[0] += $y;
    my $days = Delta_Days(@d1, @d2);

    return '0 day' if $years == 0 && $days == 0;

    my $ytext = $years ? sprintf("%d year", $years) : '';
    my $dtext = $days  ? sprintf("%d day",  $days)  : '';
    $ytext .= 's' if $years > 1;
    $dtext .= 's' if $days  > 1;

    return $ytext . ($years && $days ? ' ' : '') . $dtext;
}

for (@$cases) {
    is(date_difference($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
