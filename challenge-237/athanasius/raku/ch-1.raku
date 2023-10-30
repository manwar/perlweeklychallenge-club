use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
All dates are according to the Gregorian calendar (which first came into use on
15th October, 1582 AD).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True (the default), the output is followed by a short
   explanation, as given in the Examples.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;
my UInt constant FIRSTYR = 1582;   # The Gregorian calendar began on 15-Oct-1582
my UInt constant FIRSTMN =   10;
my UInt constant FIRSTDT =   15;
my      constant @MONTHS = Array[Str].new: < January February March April May
                                             June July August September October
                                             November December >;
my      constant @WKDAYS = Array[Str].new: < Monday Tuesday Wednesday Thursday
                                             Friday Saturday Sunday >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 237, Task #1: Seize The Day (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D :$year  where * >= FIRSTYR,         #= Year in the Gregorian calendar
    UInt:D :$month where 1 <= * <= 12,         #= Month (1 = January)
    UInt:D :$week  where 1 <= * <=  5,         #= Week of month (1 = first week)
    UInt:D :$dow   where 1 <= * <=  7          #= Day of week (1 = Monday)
)
#===============================================================================
{
    "Input:  Year = %d, Month = %d, Week = %d, Day of Week = %d\n".printf:
        $year, $month, $week, $dow;

    my UInt  $day-of-month = find-day-of-month( $year, $month, $week, $dow );

    "Output: $day-of-month".put;

    check-date( $year, $month, $day-of-month ) if $day-of-month > 0;

    if VERBOSE
    {
        if $day-of-month == 0
        {
            "\nThere isn\'t a %s %s in %s %s\n".printf:
                ordinal( $week ), @WKDAYS[ $dow - 1 ], @MONTHS[ $month - 1 ],
                $year;
        }
        else
        {
            "\nThe %s %s of %s %d is the %s\n".printf:
                ordinal( $week ), @WKDAYS[ $dow - 1 ], @MONTHS[ $month - 1 ],
                $year, ordinal( $day-of-month );
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-day-of-month
(
    UInt:D $year  where * >= FIRSTYR,          #= Year in the Gregorian calendar
    UInt:D $month where 1 <= * <= 12,          #= Month (1 = January)
    UInt:D $week  where 1 <= * <=  5,          #= Week of month (1 = first week)
    UInt:D $dow   where 1 <= * <=  7           #= Day of week (1 = Monday)
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my Date $date      = Date.new: $year, $month, 1;
    my UInt $first-dow = $date.day-of-week;
    my UInt $last-dom  = $date.days-in-month;
    my Int  $offset    = $dow - $first-dow;
            $offset   += 7 if $offset < 0;
    my UInt $day       = 1 +  $offset + ($week - 1) * 7;

    return  $day <= $last-dom ?? $day !! 0;
}

#-------------------------------------------------------------------------------
sub check-date
(
    UInt:D $year  where * >= FIRSTYR,          #= Year in the Gregorian calendar
    UInt:D $month where 1 <= * <= 12,          #= Month (1 = January)
    UInt:D $day   where 1 <= * <= 31           #= Day of the month
)
#-------------------------------------------------------------------------------
{
    if $year  <= FIRSTYR &&
      ($month <  FIRSTMN || ($month == FIRSTMN && $day < FIRSTDT))
    {
        my Str $date = '%4d-%02d-%02d'.sprintf: $year, $month, $day;

        $*ERR.put: "\nWARNING: The date $date precedes the introduction of " ~
                     'the Gregorian calendar';
    }
}

#-------------------------------------------------------------------------------
sub ordinal( UInt:D $cardinal where 1 <= * <= 31 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  $suffix = 'th';
    my UInt $ones   =  $cardinal % 10;
    my UInt $tens   = ($cardinal / 10).floor;

    unless  $tens == 1
    {
        $suffix = $ones == 1 ?? 'st' !!
                  $ones == 2 ?? 'nd' !!
                  $ones == 3 ?? 'rd' !! 'th';
    }

    return $cardinal ~ $suffix;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $year, $month, $week, $day, $expected) =
                $line.split: / \| /;

        for     $test-name, $year, $month, $week, $day, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $day-of-month =
                find-day-of-month( $year.Int, $month.Int, $week.Int, $day.Int );

        is $day-of-month, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1             |2024| 4|3|2|16
        Example 2             |2025|10|2|4| 9
        Example 3             |2026| 8|5|3| 0
        Cook reached Australia|1770| 4|3|4|19
        D-Day                 |1944| 6|1|2| 6
        END
}

################################################################################
