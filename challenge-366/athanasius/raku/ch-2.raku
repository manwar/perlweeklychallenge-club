use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 366
=========================

TASK #2
-------
*Valid Times*

Submitted by: Mohammad Sajid Anwar

You are given a time in the form 'HH:MM'. The earliest possible time is '00:00'
and the latest possible time is '23:59'. In the string time, the digits repre-
sented by the '?' symbol are unknown, and must be replaced with a digit from 0
to 9.

Write a script to return the count [of] different ways we can make it a valid
time.

Example 1

  Input: $time = "?2:34"
  Output: 3

  0 -> "02:34" valid
  1 -> "12:34" valid
  2 -> "22:34" valid

Example 2

  Input: $time = "?4:?0"
  Output: 12

  Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
  Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)

  Total: 2 × 6 = 12

Example 3

  Input: $time = "??:??"
  Output: 1440

  Hours: from 00 to 23 -> 24 possibilities
  Minutes: from 00 to 59 -> 60 possibilities

  Total: 24 × 60 = 1440

Example 4

  Input: $time = "?3:45"
  Output: 3

  If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
  If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23
  is valid

  Therefore: 0,1,2 are all valid -> 3 possibilities

Example 5

  Input: $time = "2?:15"
  Output: 4

  Tens digit is 2, so hours can be 20-23
  Ones digit can be 0,1,2,3 (4 possibilities)

  Therefore: 4 valid times

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
If a time is fully specified (i.e., contains no "?" characters), then the count
of valid times is 1 if the time is valid and 0 otherwise.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A time in the form "HH:MM" is entered on the command-line.

=end comment
#===============================================================================

use Test;

my regex Chr { <[ 0 .. 9 ? ]> };

subset Time of Str where { / ^ &Chr &Chr \: &Chr &Chr $ / };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 366, Task #2: Valid Times (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Time:D $time   #= A time in the form "HH:MM" where H and M are digits or "?"
)
#===============================================================================
{
    qq[Input:  \$time = "$time"].put;

    my UInt $count = count-valid-times( $time );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-valid-times( Time:D $time --> UInt:D )
#-------------------------------------------------------------------------------
{
    $time ~~ / ^ (..) \: (..) $ /;

    return count-valid-hours( ~$0 ) * count-valid-mins( ~$1 );
}

#-------------------------------------------------------------------------------
sub count-valid-hours( Str:D $hours --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    $hours ~~ / ^ (.) (.) $ /;

    my Str $tens = ~$0;
    my Str $ones = ~$1;

    if    $tens eq '?'          # ?? or ?d
    {
        $count = ($ones eq '?') ?? 24 !! (4 > $ones)  ?? 3 !!  2;
    }
    elsif $ones eq '?'          # d?
    {
        $count = ($tens  >  2 ) ??  0 !! ($tens == 2) ?? 4 !! 10;
    }
    else                        # dd
    {
        $count = 1 if 24 > +( $tens ~ $ones );
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub count-valid-mins( Str:D $mins --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    $mins ~~ / ^ (.) (.) $ /;

    my Str $tens = ~$0;
    my Str $ones = ~$1;

    if    $tens eq '?'          # ?? or ?d
    {
        $count = ($ones eq '?') ?? 60 !!  6;
    }
    elsif $ones eq '?'          # d?
    {
        $count = ($tens  >  5 ) ??  0 !! 10;
    }
    else                        # dd
    {
        $count = 1 if 60 > +( $tens ~ $ones );
    }

    return $count;
}

=begin comment
#-------------------------------------------------------------------------------
sub valid-time( UInt:D $hours, UInt:D $mins --> Bool:D )
#-------------------------------------------------------------------------------
{
    return (24 > $hours >= 0) && (60 > $mins >= 0);    
}
=end comment

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $time, $expected) = $line.split: / \| /;

        for     $test-name, $time, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $count = count-valid-times( $time );

        is $count, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|?2:34|   3
        Example 2|?4:?0|  12
        Example 3|??:??|1440
        Example 4|?3:45|   3
        Example 5|2?:15|   4
        Valid    |12:34|   1
        Invalid 1|43:21|   0
        Invalid 2|3?:00|   0
        Invalid 3|0?:7?|   0
        END
}

################################################################################
