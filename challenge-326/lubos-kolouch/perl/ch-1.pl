#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Day of the Year (Weekly Challenge 326)

Given a date in YYYY-MM-DD, return its day-of-year number.

=cut

sub is_leap ($year) {
    return 0 if $year % 4;
    return 1 if $year % 100;
    return 0 if $year % 400;
    return 1;
}

sub day_of_year ($date) {
    my ($y, $m, $d) = split /-/, $date;
    my @month_days = (0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    $month_days[2] = 29 if is_leap($y);
    my $sum = $d;
    $sum += $month_days[$_] for 1 .. $m - 1;
    return $sum;
}

if (!caller) {
    require Test::More;
    Test::More::is( day_of_year('2025-02-02'), 33,  'Example 1' );
    Test::More::is( day_of_year('2025-04-10'), 100, 'Example 2' );
    Test::More::is( day_of_year('2025-09-07'), 250, 'Example 3' );
    Test::More::done_testing();
}
