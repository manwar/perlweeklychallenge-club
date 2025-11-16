use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

use Test;

enum   Status < Valid Out-of-range Not-a-leap-year >;
subset Result of List where (Status, Str);

my constant @DAYS   = Array[Str].new:
                      < 1st  2nd  3rd  4th  5th  6th  7th  8th  9th 10th
                       11th 12th 13th 14th 15th 16th 17th 18th 19th 20th
                       21st 22nd 23rd 24th 25th 26th 27th 28th 29th 30th 31st >;
my constant @MONTHS = Array[Str].new: 
                      < Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec >;
my constant @YEARS  = Array[UInt].new: 1900 .. 2100;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 347, Task #1: Format Date (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str            #= A date with the format "10th Nov 2025"
)
#===============================================================================
{
    main( $str );
}

#===============================================================================
multi sub MAIN
(
    Str:D  $date,         #= A date such as "1st", "22nd", or "30th"
    Str:D  $month,        #= A month such as "Jan" or "Feb"
    UInt:D $year          #= A year in the range 1900 to 2100 inclusive
)
#===============================================================================
{
    main( "$date $month $year" );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub main( Str:D $str )
#-------------------------------------------------------------------------------
{
    qq[Input:  \$str = "$str"].put;

    my (Status $status, Str $date) = format-date( $str );

    qq[Output: "$date"].put;

    if    $status == Out-of-range
    {
        "\nNote: The date is invalid: out of range".put;
    }
    elsif $status == Not-a-leap-year
    {
        "\nNote: The date is invalid: not a leap year".put;
    }
}

#-------------------------------------------------------------------------------
sub format-date( Str:D $str --> Result:D )
#-------------------------------------------------------------------------------
{
    my Status $status = Valid;

    $str ~~ / ^ (\w ** 3..4) \s (\w ** 3) \s (\d ** 4) $ /
                          or error( 'The input date is incorrectly formatted' );

    my Str  $day   = ~$0;
    my Str  $month = ~$1;
    my UInt $year  = +$2;

    @DAYS\ .first: $day   or error( 'The day "'   ~ $day   ~ '" is invalid' );
    @MONTHS.first: $month or error( 'The month "' ~ $month ~ '" is invalid' );
    @YEARS\.first: $year  or error( 'The year "'  ~ $year  ~ '" is invalid' );

    my UInt $date = (S/ \D ** 2 $ // with $day).Int;

    if    $month eq 'Feb'
    {
        if    $date == 29
        {
            $status = Not-a-leap-year if !($year %%   4) ||
                                         (($year %% 100) && !($year %% 400));
        }
        elsif $date >= 30
        {
            $status = Out-of-range;
        }
    }
    elsif $month eq < Apr Jun Sep Nov >.any
    {
        $status = Out-of-range if $date == 31;
    }

    my Str $formatted-date = '%4d-%02d-%02d'.sprintf:
                              $year, (@MONTHS.first: $month, :k) + 1, $date;

    return ($status, $formatted-date);
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my (Status $status, Str $date) = format-date( $str );

        $status == Valid or die "Invalid date: $str";

        is $date, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "\nERROR: $message".put;

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
        Example 1| 1st Jan 2025|2025-01-01
        Example 2|22nd Feb 2025|2025-02-22
        Example 3|15th Apr 2025|2025-04-15
        Example 4|23rd Oct 2025|2025-10-23
        Example 5|31st Dec 2025|2025-12-31
        END
}

################################################################################
