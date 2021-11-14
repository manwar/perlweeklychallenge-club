#!/usr/bin/perl

=head1

Week 138:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-138

Task #1: Workdays

    You are given a year in 4-digits form. Write a script to calculate the total number of workdays in the given year.

=cut

use strict;
use warnings;

use Test::More;
use Date::Calc qw(Day_of_Week Add_Delta_Days);

is(workdays(2021), 261, 'Example 1');
is(workdays(2020), 262, 'Example 2');

done_testing;

sub workdays {
    my ($year) = @_;

    my $d = 1;
    my $m = 1;
    my $y = $year;

    my $workdays = 0;
    while ($year == $y) {
        (Day_of_Week($y, $m, $d) < 6) and $workdays++;
        ($y, $m, $d) = Add_Delta_Days($y, $m, $d, 1);
    }

    return $workdays;
}
