#!/usr/bin/perl

=head1

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #1: Last Sunday

    Write a script to list Last Sunday of every month in the given year.

=cut

use v5.36;
use DateTime;
use Test2::V0;

my $got = all_last_sunday_of(2022);
my $exp = [
    '2022-01-30', '2022-02-27', '2022-03-27', '2022-04-24',
    '2022-05-29', '2022-06-26', '2022-07-31', '2022-08-28',
    '2022-09-25', '2022-10-30', '2022-11-27', '2022-12-25',
];

is $exp, $got;

done_testing;

#
#
# METHODS

sub all_last_sunday_of($year) {
    my @ls = ();
    push @ls, last_sunday_of($_, $year) for (1..12);
    return \@ls;
}

sub last_sunday_of($month, $year) {
    my $dt = DateTime->new(year => $year, month => $month, day => 1)
                     ->add(months => 1)
                     ->subtract(days => 1);

    my $dow = $dt->day_of_week;
    $dt->subtract(days => $dow) if $dow != 7;

    return $dt->ymd('-');
}
