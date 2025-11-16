#!perl

################################################################################
=comment

Perl Weekly Challenge 347
=========================

TASK #1
-------
*Format Date*

Submitted by: Mohammad Sajid Anwar

You are given a date in the form: 10th Nov 2025.

Write a script to format the given date in the form: 2025-11-10 using the set
below.

  @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
  @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
  @YEARS  = (1900..2100)

Example 1

  Input: $str = "1st Jan 2025"
  Output: "2025-01-01"

Example 2

  Input: $str = "22nd Feb 2025"
  Output: "2025-02-22"

Example 3

  Input: $str = "15th Apr 2025"
  Output: "2025-04-15"

Example 4

  Input: $str = "23rd Oct 2025"
  Output: "2025-10-23"

Example 5

  Input: $str = "31st Dec 2025"
  Output: "2025-12-31"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A date in the form "10th Nov 2025" is entered on the command-line, either:
   i. as a single string; or
  ii. as three separate strings.

Date Validity
-------------
Valid dates are defined by the set (@DAYS, @MONTHS, @YEARS). Dates falling out-
side this set (e.g., "21th Jan 2025", "1st XYZ 2025", "1st Jan 1899") are
rejected. Dates falling within the set are accepted and formatted; but, if they
are in fact invalid (e.g., "31st Apr 2025", "29th Feb 2025"), they are flagged
as such in an appended message.

Leap Years
----------
From https://en.wikipedia.org/wiki/Leap_year#Gregorian_calendar
"Every year that is exactly divisible by four is a leap year, except for years
 that are exactly divisible by 100, but these centurial years are leap years if
 they are exactly divisible by 400. For example, the years 1700, 1800, and 1900
 are not leap years, but the years 1600 and 2000 are."

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( any firstidx firstval );
use Test::More;
use enum            qw( VALID OUT_OF_RANGE NOT_A_LEAP_YEAR );

const my @DAYS   => qw( 1st  2nd  3rd  4th  5th  6th  7th  8th  9th 10th
                       11th 12th 13th 14th 15th 16th 17th 18th 19th 20th
                       21st 22nd 23rd 24th 25th 26th 27th 28th 29th 30th 31st );
const my @MONTHS => qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
const my @YEARS  => (1900 .. 2100);

const my $USAGE  => <<END;
Usage:
  perl $0 <str>
  perl $0 <date> <month> <year>
  perl $0

    <str>      A date with the format "10th Nov 2025"
    <date>     A date such as "1st", "22nd", or "30th"
    <month>    A month such as "Jan" or "Feb"
    <year>     A year in the range 1900 to 2100 inclusive
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 347, Task #1: Format Date (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        main( $ARGV[0] );
    }
    elsif ($argc == 3)
    {
        main( join ' ', @ARGV );
    }
    else
    {
        error( "Expected 0, 1, or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub main
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    print qq[Input:  \$str = "$str"\n];

    my ($status, $date) = format_date( $str );

    print qq[Output: "$date"\n];

    if    ($status == OUT_OF_RANGE)
    {
        print "\nNote: The date is invalid: out of range\n";
    }
    elsif ($status == NOT_A_LEAP_YEAR)
    {
        print "\nNote: The date is invalid: not a leap year\n";
    }
}

#-------------------------------------------------------------------------------
sub format_date
#-------------------------------------------------------------------------------
{
    my ($str)   = @_;
    my  $status = VALID;

    my ($day, $month, $year) = $str =~ / ^ (\w{3,4}) \s (\w{3}) \s (\d{4}) $ /x
                          or error( 'The input date is incorrectly formatted' );

    firstval { $_ eq $day   } @DAYS
                          or error( 'The day "'   . $day   . '" is invalid' );
    firstval { $_ eq $month } @MONTHS
                          or error( 'The month "' . $month . '" is invalid' );
    firstval { $_ eq $year  } @YEARS
                          or error( 'The year "'  . $year  . '" is invalid' );

    my ($date) = $day =~ / ^ (\d{1,2}) /x;

    if    ($month eq 'Feb')
    {
        if    ($date == 29)
        {
            $status = NOT_A_LEAP_YEAR if ($year %   4) ||
                                       (!($year % 100) && ($year % 400));
        }
        elsif ($date >= 30)
        {
            $status = OUT_OF_RANGE;
        }
    }
    elsif (any { $_ eq $month } qw( Apr Jun Sep Nov ))
    {
        $status = OUT_OF_RANGE if $date == 31;
    }

    my $formatted_date = sprintf '%4d-%02d-%02d',
                         $year, (firstidx { $_ eq $month } @MONTHS) + 1, $date;

    return ($status, $formatted_date);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($status, $date) = format_date( $str );

        $status == VALID or die "Invalid date: $str";

        is $date, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "\nERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1| 1st Jan 2025|2025-01-01
Example 2|22nd Feb 2025|2025-02-22
Example 3|15th Apr 2025|2025-04-15
Example 4|23rd Oct 2025|2025-10-23
Example 5|31st Dec 2025|2025-12-31
