#!perl

###############################################################################
=comment

Perl Weekly Challenge 138
=========================

TASK #1
-------
*Workdays*

Submitted by: Mohammad S Anwar

You are given a year, $year in 4-digits form.

Write a script to calculate the total number of workdays in the given year.

    For the task, we consider, Monday - Friday as workdays.

Example 1

 Input: $year = 2021
 Output: 261

Example 2

 Input: $year = 2020
 Output: 262

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
A common year has 365 days, a leap year 366. 52 weeks is 364 days, and those 52
weeks are guaranteed to contain (52 * 5) = 260 "workdays". So the total number
of workdays in the year is determined by whether the extra days -- 1 in a
common year, or 2 in a leap year -- fall on or between weekends.

If a year begins on a Monday, then the final day of the 52-week block of days
must be a Sunday: in which case, the following day(s) fall between weekends. A
similar reasoning is easily applied to the other days of the week. For example,
if the year begins on a Sunday, then the final day of the 52-week block of days
must be a Saturday, and therefore the following day falls on a Sunday, and does
NOT add to the total of workdays; but the day after that (if this is a leap
year) falls on a Monday and DOES add to the total.

In the solution below, these extra days have been pre-computed and stored in
the constant arrays @COMMON and @LEAP_Y. The CPAN DateTime module is used to
determine the day of the week on which the first day of the year falls, and
also whether or not the year is a leap year. (Note the use of DateTime's
day_of_week_0() method, which returns weekdays in 0-based order beginning with
Monday.)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;
use Regexp::Common qw( number );

const my $BASE   => 260;                      # 52 * 5
const my @COMMON => ( 1, 1, 1, 1, 1, 0, 0 );  # Extra workday for a common year
const my @LEAP_Y => ( 1, 1, 1, 1, 0, 0, 1 );  # Extra workday for a leap   year
const my $USAGE  =>
"Usage:
  perl $0 <year>

    <year>    Year in 4-digits form\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 138, Task #1: Workdays (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($year) = parse_command_line();

    print "Input:  \$year = $year\n";

    my $dt_jan_1  = DateTime->new( year => $year, month => 1, day => 1 );
    my $day_of_wk = $dt_jan_1->day_of_week_0;               # 0-6 (Monday is 0)
    my $workdays  = $COMMON[ $day_of_wk ] + $BASE;
       $workdays += $LEAP_Y[ $day_of_wk ] if $dt_jan_1->is_leap_year;

    print "Output: $workdays\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $year = $ARGV[ 0 ];

    $year =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$year" is not a valid integer] );

    1 <= $year <= 9999
                  or error( qq["$year" is not in 4-digit form] );

    return $year + 0;                                               # Normalize
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
