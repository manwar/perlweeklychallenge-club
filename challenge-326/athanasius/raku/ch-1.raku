use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 326
=========================

TASK #1
-------
*Day of the Year*

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.

Example 1

  Input: $date = '2025-02-02'
  Output: 33

  The 2nd Feb, 2025 is the 33rd day of the year.

Example 2

  Input: $date = '2025-04-10'
  Output: 100

Example 3

  Input: $date = '2025-09-07'
  Output: 250

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
2. A valid date in the format "YYYY-MM-DD" is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 326, Task #1: Day of the Year (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A valid date in the format "YYYY-MM-DD"

    Str $date where / ^ \d**4 \- \d\d \- \d\d $ /
)
#===============================================================================
{
    my Date $date-obj = Date.new: $date;

    "Input:  \$date = '$date'".put;

    my UInt $day-of-year = find-day-of-year( $date-obj );

    "Output: $day-of-year".put;

    CATCH
    {
        default { error( .message ); }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-day-of-year( Date:D $date --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Date $start = $date.truncated-to( 'year' );

    return $date.daycount - $start.daycount + 1;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $date, $expected) = $line.split: / \| /;

        for     $test-name, $date, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $day-of-year = find-day-of-year( Date.new( $date ) );

        is $day-of-year, $expected.Int, $test-name;
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
        Example 1|2025-02-02| 33
        Example 2|2025-04-10|100
        Example 3|2025-09-07|250
        END
}

################################################################################
