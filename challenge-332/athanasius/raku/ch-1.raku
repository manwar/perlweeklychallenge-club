use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 332
=========================

TASK #1
-------
*Binary Date*

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to convert it into binary date.

Example 1

  Input: $date = "2025-07-26"
  Output: "11111101001-111-11010"

Example 2

  Input: $date = "2000-02-02"
  Output: "11111010000-10-10"

Example 3

  Input: $date = "2024-12-31"
  Output: "11111101000-1100-11111"

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

Assumption
----------
Dates must be valid.

=end comment
#===============================================================================

use Test;

my regex Date { ^ (\d**4) \- (\d\d) \- (\d\d) $ };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 332, Task #1: Binary Date (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $date where m/ <Date> /     #= A valid date in the format "YYYY-MM-DD"
)
#===============================================================================
{
    my Str $msg = date-is-valid( $date );
           $msg and error( "Invalid date: $msg" );

    qq[Input:  \$date = "$date"].put;

    my Str $bin-date = find-binary-date( $date );

    qq[Output: "$bin-date"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-binary-date( Str:D $str where m/ <date=Date> / --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $msg = date-is-valid( $str );
           $msg and die( "Invalid date: $msg" );

    my Str $bin-year  = $<date>[ 0 ].Int.base( 2 );
    my Str $bin-month = $<date>[ 1 ].Int.base( 2 );
    my Str $bin-day   = $<date>[ 2 ].Int.base( 2 );

    return $bin-year ~ '-' ~ $bin-month ~ '-' ~ $bin-day;
}

#-------------------------------------------------------------------------------
sub date-is-valid
(
    Str:D $date
--> Str:D                      #= Returns the empty string if the date is valid;
                               #= otherwise, returns an error message
)
#-------------------------------------------------------------------------------
{
    my Str $result = '';

    try
    {
        CATCH
        {
            when X::Temporal
            {
                $result = .message;
            }
        }

        Date.new: $date;
    }

    return $result;
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

        my Str $bin-date = find-binary-date( $date );

        is $bin-date, $expected, $test-name;
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
        Example 1|2025-07-26|11111101001-111-11010
        Example 2|2000-02-02|11111010000-10-10
        Example 3|2024-12-31|11111101000-1100-11111
        END
}

################################################################################
