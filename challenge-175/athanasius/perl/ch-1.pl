#!perl

###############################################################################
=comment

Perl Weekly Challenge 175
=========================

TASK #1
-------
*Last Sunday*

Submitted by: Mohammad S Anwar

Write a script to list Last Sunday of every month in the given year.

For example, for year 2022, we should get the following:

  2022-01-30
  2022-02-27
  2022-03-27
  2022-04-24
  2022-05-29
  2022-06-26
  2022-07-31
  2022-08-28
  2022-09-25
  2022-10-30
  2022-11-27
  2022-12-25

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
All dates are interpreted according to the Gregorian calendar [1,3]. Dates
prior to 15th October, 1582, when the Gregorian calendar was first introduced,
are calculated according to the "proleptic Gregorian calendar" [3] which
extends backwards to dates before the calendar was in use. However, dates prior
to the year 1 AD are not supported.

Solution
--------
The solution uses the CPAN module DateTime [2]. Its last_day_of_month()
constructor automatically finds the last day of February as 28 or 29, according
to whether or not the year is a leap year.

Then, DateTime's day_of_the_week() method finds the weekday of the last day in
the month: it "[r]eturns the day of the week as a number, from 1..7, with 1
being Monday and 7 being Sunday." [2] If the last day is a Monday, then the
last Sunday is one day prior; if a Tuesday, it is two days prior; and so on.
Hence, the date of the last Sunday is calculated by subtracting from the date
of the last day the weekday of the last day modulo 7.

References
----------
[1]  Claus Tøndering, "The Gregorian calendar", The Calendar FAQ,
     https://www.tondering.dk/claus/cal/gregorian.php
[2]  Dave Rolsky, "DateTime", MetaCPAN, https://metacpan.org/pod/DateTime
[3] "Gregorian calendar", Wikipedia,
     https://en.wikipedia.org/wiki/Gregorian_calendar

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <year>

    <year>    A year in the Gregorian calendar (AD)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 175, Task #1: Last Sunday (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $year = parse_command_line();

    print "The last Sunday of each month in the year $year:\n\n";

    for my $month (1 .. 12)
    {
        my $last_day_dt = DateTime->last_day_of_month
                          (
                              year  => $year,
                              month => $month,
                          );
        my $last_day    = $last_day_dt->day;
        my $day_of_week = $last_day_dt->day_of_week;
        my $last_sun_dt = DateTime->new
                          (
                              year  => $year,
                              month => $month,
                              day   => $last_day - ($day_of_week % 7),
                          );
        
        printf "  %s\n", $last_sun_dt->ymd;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $year = $ARGV[ 0 ];

    $year =~ / ^ $RE{num}{int} $ /x
                  or error( qq[Argument "$year" is not a valid integer] );

    $year >= 1    or error( qq[Year "$year" is not AD] );

    return $year;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
