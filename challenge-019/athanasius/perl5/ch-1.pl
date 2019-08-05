#!perl

################################################################################
=comment

Perl Weekly Challenge 019
=========================

Task #1
-------
Write a script to display months from the year 1900 to 2019 where you find 5
weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $FIRST_YEAR => 1900;
const my $LAST_YEAR  => 2019;
const my $FRIDAY     =>    5;    # DateTime::day_of_week() --> 1-7 (Monday is 1)
const my $TARGET_DAY =>   29;
const my @MONTHS_31  =>  ( 1, 3, 5, 7, 8, 10, 12 );

MAIN:
{
    my $count = 0;

    printf "\nMonths between %d and %d containing 5 Fridays, Saturdays, and " .
             "Sundays:\n\n", $FIRST_YEAR, $LAST_YEAR;

    for my $year ($FIRST_YEAR .. $LAST_YEAR)
    {
        my @months;

        for my $month (@MONTHS_31)
        {
            my $dt = DateTime->new
                     (
                         year  => $year,
                         month => $month,
                         day   => $TARGET_DAY,
                     );

            if ($dt->day_of_week() == $FRIDAY)
            {
                push @months, $dt->month_name();
                ++$count;
            }
        }

        printf "%d: %s\n", $year, join(' and ', @months) if scalar @months;
    }

    print "\nTotal: $count months\n";
}

################################################################################

__END__

Analysis

The smallest month is February in a non-leap year, with 28 days. Since days of
the week are consecutive, a 28-day period contains exactly 4 of each of the 7
days of the week. To have an additional (i.e., 5th) Friday, Saturday, and Sunday
requires an additional 3 days, 28 + 3 = 31, so only the 7 months containing 31
days need be considered: January, March, May, July, August, October, and
December.

Moreover, the only way to fit 5 Fridays, 5 Saturdays, and 5 Sundays into a 31-
day month is to have "weekends" on days 1-3, 8-10, 15-17, 22-24, and 29-31. So
only months beginning on a Friday -- or, equivalently, months in which the 29th
day is a Friday -- are candidates.

So the task becomes this: For the years 1900 to 2019 (inclusive), find any
January, March, May, July, August, October, or December that begins on a Friday,
or that has its 29th day fall on a Friday.
