#!perl

###############################################################################
=comment

Perl Weekly Challenge 137
=========================

TASK #1
-------
*Long Year*

Submitted by: Mohammad S Anwar

Write a script to find all the years between 1900 and 2100 which is a Long
Year.

    A year is Long if it has 53 weeks.

[UPDATED][2021-11-01 16:20:00]: For more information about Long Year, please
refer to [ https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year |wiki-
pedia].

Expected Output

  1903, 1908, 1914, 1920, 1925,
  1931, 1936, 1942, 1948, 1953,
  1959, 1964, 1970, 1976, 1981,
  1987, 1992, 1998, 2004, 2009,
  2015, 2020, 2026, 2032, 2037,
  2043, 2048, 2054, 2060, 2065,
  2071, 2076, 2082, 2088, 2093,
  2099

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------

From https://en.wikipedia.org/wiki/Week#Week_52_and_53 :-

    "Week 52 and 53

    It is also possible to determine if the last week of the previous year was
    Week 52 or Week 53 as follows:

     - If January 1 falls on a Friday, then it is part of Week 53 of the
       previous year (W53-5).
     - If January 1 falls on a Saturday,
         - then it is part of Week 53 of the previous year if that is a leap
           year (W53-6),
         - and part of Week 52 otherwise (W52-6), i.e. if the previous year is
           a common year.
     - If January 1 falls on a Sunday, then it is part of Week 52 of the
       previous year (W52-7)."

Implementation
--------------
The CPAN DateTime module provides methods day_of_week() and is_leap_year().

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $START     => 1_900;
const my $END       => 2_100;
const my $YR_PER_LN =>     5;
const my $FRIDAY    =>     5;
const my $SATURDAY  =>     6;
const my $USAGE     => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 137, Task #1: Long Year (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    die "ERROR: Expected 0 command line arguments, found $args\n$USAGE"
        unless $args == 0;

    my @long_years;

    for my $year ($START .. $END)
    {
        my $jan1 = DateTime->new( year => $year + 1, month => 1, day => 1 );
        my $dow  = $jan1->day_of_week;

        if    ($dow == $FRIDAY)
        {
            push @long_years, $year;
        }
        elsif ($dow == $SATURDAY)
        {
            my $dt = DateTime->new( year => $year );

            push @long_years, $year if $dt->is_leap_year;
        }
    }

    print_years( \@long_years );
}

#------------------------------------------------------------------------------
sub print_years
#------------------------------------------------------------------------------
{
    my ($long_years) = @_;

    printf "There are %d long years between %d and %d inclusive:\n\n",
            scalar @$long_years, $START, $END;

    my $idx = 0;

    while ($idx + $YR_PER_LN - 1 < $#$long_years)
    {
        printf "%s,\n",
                    join ', ', @$long_years[ $idx .. $idx + $YR_PER_LN - 1 ];
        $idx += $YR_PER_LN;
    }

    printf "%s\n",  join ', ', @$long_years[ $idx .. $#$long_years ];
}

###############################################################################
