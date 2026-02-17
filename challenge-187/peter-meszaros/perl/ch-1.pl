#!/usr/bin/env perl
#
=head1 Task 1: Days Together

Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city. You are
given their schedule i.e. start date and end date.  To keep the task simple,
the date is in the form DD-MM and all dates belong to the same calendar year
i.e. between 01-01 and 31-12. Also the year is non-leap year and both dates are
inclusive.  Write a script to find out for the given schedule, how many days
they spent together in the city, if at all.

=head2 Example 1

    Input: Foo => SD: '12-01' ED: '20-01'
           Bar => SD: '15-01' ED: '18-01'

    Output: 4 days

=head2 Example 2

    Input: Foo => SD: '02-03' ED: '12-03'
           Bar => SD: '13-03' ED: '14-03'

    Output: 0 day

=head2 Example 3

    Input: Foo => SD: '02-03' ED: '12-03'
           Bar => SD: '11-03' ED: '15-03'

    Output: 2 days

=head2 Example 4

    Input: Foo => SD: '30-03' ED: '05-04'
           Bar => SD: '28-03' ED: '02-04'

    Output: 4 days

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Date::Calc qw/Day_of_Year/;
use List::Util qw/min max/;

my $cases = [
    [{Foo => {SD => '12-01', ED => '20-01'},
      Bar => {SD => '15-01', ED => '18-01'}}, 4, "Example 1"],
    [{Foo => {SD => '02-03', ED => '12-03'},
      Bar => {SD => '13-03', ED => '14-03'}}, 0, "Example 2"],
    [{Foo => {SD => '02-03', ED => '12-03'},
      Bar => {SD => '11-03', ED => '15-03'}}, 2, "Example 3"],
    [{Foo => {SD => '30-03', ED => '05-04'},
      Bar => {SD => '28-03', ED => '02-04'}}, 4, "Example 4"],
];

sub days_together
{
    my $schedule = shift;

    my ($foo_sd, $foo_ed) = @{$schedule->{Foo}}{qw(SD ED)};
    my ($bar_sd, $bar_ed) = @{$schedule->{Bar}}{qw(SD ED)};

    my $year = 2026; # non-leap year
    my ($foo_sd_d, $foo_sd_m) = split /-/, $foo_sd;
    my ($foo_ed_d, $foo_ed_m) = split /-/, $foo_ed;
    my ($bar_sd_d, $bar_sd_m) = split /-/, $bar_sd;
    my ($bar_ed_d, $bar_ed_m) = split /-/, $bar_ed;

    my $foo_sd_diy = Day_of_Year($year, $foo_sd_m, $foo_sd_d);
    my $foo_ed_diy = Day_of_Year($year, $foo_ed_m, $foo_ed_d);
    my $bar_sd_diy = Day_of_Year($year, $bar_sd_m, $bar_sd_d);
    my $bar_ed_diy = Day_of_Year($year, $bar_ed_m, $bar_ed_d);

    my $overlap = min($foo_ed_diy, $bar_ed_diy) -
                  max($foo_sd_diy, $bar_sd_diy) + 1;
    return abs($overlap);
}

for (@$cases) {
    is(days_together($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
