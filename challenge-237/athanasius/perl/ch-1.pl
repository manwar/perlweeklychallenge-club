#!perl

################################################################################
=comment

Perl Weekly Challenge 237
=========================

TASK #1
-------
*Seize The Day*

Submitted by: Mark Anderson

Given a year, a month, a weekday of month, and a day of week
(1 (Mon) .. 7 (Sun)), print the day.

Example 1

  Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
  Output: 16

  The 3rd Tue of Apr 2024 is the 16th

Example 2

  Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
  Output: 9

  The 2nd Thu of Oct 2025 is the 9th

Example 3

  Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
  Output: 0

  There isn't a 5th Wed in Aug 2026

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
All dates are according to the Gregorian calendar (which first came into use on
15th October, 1582 AD).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output is followed by a
   short explanation, as given in the Examples.

=cut
#===============================================================================

use v5.32.1;
use warnings;
use Const::Fast;
use DateTime       qw( day_of_week month_length );
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE =>    1;
const my $FIRSTYR => 1582;         # The Gregorian calendar began on 15-Oct-1582
const my $FIRSTMN =>   10;
const my $FIRSTDT =>   15;
const my @MONTHS  => qw( January February  March     April    May    June   July
                         August  September October   November December );
const my @WKDAYS  => qw( Monday  Tuesday   Wednesday Thursday Friday Saturday
                         Sunday );
const my $USAGE   =>
"Usage:
  perl $0 [--year[=Int]] [--month[=Int]] [--week[=Int]] [--dow[=Int]]
  perl $0

    --year [=Int $FIRSTYR+]    Year in the Gregorian calendar
    --month[=Int 1-12 ]    Month         (1 = January)
    --week [=Int 1-5  ]    Week of month (1 = first week)
    --dow  [=Int 1-7  ]    Day  of week  (1 = Monday)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 237, Task #1: Seize The Day (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($year, $month, $week, $dow) = parse_command_line();

        printf "Input:  Year = %d, Month = %d, Week = %d, Day of Week = %d\n",
            $year, $month, $week, $dow;

        my $day_of_month = find_day_of_month( $year, $month, $week, $dow );

        print "Output: $day_of_month\n";

        check_date( $year, $month, $day_of_month ) if $day_of_month > 0;

        if ($VERBOSE)
        {
            if ($day_of_month == 0)
            {
                printf "\nThere isn\'t a %s %s in %s %s\n", ordinal( $week ),
                        $WKDAYS[ $dow - 1 ], $MONTHS[ $month - 1 ],  $year;
            }
            else
            {
                printf "\nThe %s %s of %s %d is the %s\n",  ordinal( $week ),
                        $WKDAYS[ $dow - 1 ], $MONTHS[ $month - 1 ],  $year,
                        ordinal( $day_of_month );
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub find_day_of_month
#-------------------------------------------------------------------------------
{
    my ($year, $month, $week, $dow) = @_;
    my  $date      = DateTime->new( year => $year, month => $month, day => 1 );
    my  $first_dow = $date->day_of_week;
    my  $last_dom  = $date->month_length;
    my  $offset    = $dow - $first_dow;
        $offset   += 7 if $offset < 0;
    my  $day       = 1 +  $offset + ($week - 1) * 7;

    return $day <= $last_dom ? $day : 0;
}

#-------------------------------------------------------------------------------
sub check_date
#-------------------------------------------------------------------------------
{
    my ($year, $month, $day) = @_;

    if ($year  <= $FIRSTYR &&
       ($month <  $FIRSTMN || ($month == $FIRSTMN && $day < $FIRSTDT)))
    {
        my $date = sprintf '%4d-%02d-%02d', $year, $month, $day;

        warn "\nWARNING: The date $date precedes the introduction of the " .
               "Gregorian calendar\n";
    }
}

#-------------------------------------------------------------------------------
sub ordinal
#-------------------------------------------------------------------------------
{
    my ($cardinal) = @_;
    my  $suffix    = 'th';
    my  $ones      = $cardinal % 10;
    my  $tens      = int( $cardinal / 10 );

    unless ($tens == 1)
    {
        $suffix = $ones == 1 ? 'st' :
                  $ones == 2 ? 'nd' :
                  $ones == 3 ? 'rd' : 'th';
    }

    return $cardinal . $suffix;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($year, $month, $week, $dow);

    GetOptions
    (
        'year=i'  => \$year,
        'month=i' => \$month,
        'week=i'  => \$week,
        'dow=i'   => \$dow,

    ) or error( 'Invalid in command-line arguments' );

    for ([ 'year',            $year  ],
         [ 'month',           $month ],
         [ 'week',            $week  ],
         [ 'day of the week', $dow   ])
    {
        my ($name, $value) = @$_;

        defined $value or error( "Missing $name" );

        $value =~ / ^ $RE{num}{int} $ /x
            or error( qq[$name "$value" is not a valid integer] );
    }

    $year >= $FIRSTYR or error( "$year precedes the introduction of the " .
                                'Gregorian calendar' );
    1 <= $month <= 12 or error( "$month is not a valid month" );
    1 <= $week  <=  5 or error( "$week is not a valid week" );
    1 <= $dow   <=  7 or error( "$dow is not a valid day of the week" );
    scalar @ARGV == 0 or error( 'Unrecognised command-line argument' );

    return ($year, $month, $week, $dow);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $year, $month, $week, $day, $expected) =
             split / \| /x, $line;

        for ($test_name, $year, $month, $week, $day, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $day_of_month = find_day_of_month( $year, $month, $week, $day );

        is $day_of_month, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1             |2024| 4|3|2|16
Example 2             |2025|10|2|4| 9
Example 3             |2026| 8|5|3| 0
Cook reached Australia|1770| 4|3|4|19
D-Day                 |1944| 6|1|2| 6
