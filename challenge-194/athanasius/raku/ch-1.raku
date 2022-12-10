use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 194
=========================

TASK #1
-------
*Digital Clock*

Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.

Write a script to find the highest digit between 0-9 that makes it valid time.

Example 1

  Input: $time = '?5:00'
  Output: 1

  Since 05:00 and 15:00 are valid time and no other digits can fit in the
  missing place.

Example 2

  Input: $time = '?3:00'
  Output: 2

Example 3

  Input: $time = '1?:00'
  Output: 9

Example 4

  Input: $time = '2?:00'
  Output: 3

Example 5

  Input: $time = '12:?5'
  Output: 5

Example 6

  Input: $time = '12:5?'
  Output: 9

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Algorithm
---------
Let the input be symbolized "wx:yz". There are 4 positions in which a digit can
be replaced by a question mark; each of these positions is treated as a sepa-
rate case:

  1. ?x:yz - if x is 0, 1, 2, or 3, then the highest value of w is 2; other-
             wise, it is 1.
  2. w?:yz - if w is 2, then the highest value of x is 3; otherwise, it is 9.
  3. wx:?z - the highest possible value of y is always 5.
  4. wx:y? - the highest possible value of z is always 9.

=end comment
#==============================================================================

use Test;

subset Digit of Int where 0 <= * <= 9;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 194, Task #1: Digital Clock (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| Time in the format "hh:mm" with one digit replaced by "?"

    Str:D $time where input-is-valid( $_ )
)
#==============================================================================
{
    "Input:  \$time = '$time'".put;

    my Digit $hd = find-highest-digit( $time );

    "Output: $hd".put;
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-highest-digit( Str:D $time --> Digit:D )
#------------------------------------------------------------------------------
{
    my Str   $hour-orig   = $time.substr: 0, 2;
    my Str   $hour-new    = $hour-orig;
    my Str   $minute-orig = $time.substr: 3, 2;
    my Str   $minute-new  = $minute-orig;
    my Digit $digit;

    if    $hour-orig   ~~ / ^ \? (\d) $ /                        # Hour:   tens
    {
        $hour-new.substr-rw( 0, 1 )   = $digit = ($0.Int < 4) ?? 2 !! 1;
    }
    elsif $hour-orig   ~~ / ^ (\d) \? $ /                        # Hour:   ones
    {
        $hour-new.substr-rw( 1, 1 )   = $digit = ($0.Int < 2) ?? 9 !! 3;
    }
    elsif $minute-orig ~~ / ^ \? /                               # Minute: tens
    {
        $minute-new.substr-rw( 0, 1 ) = $digit = 5;
    }
    else                                                         # Minute: ones
    {
        $minute-new.substr-rw( 1, 1 ) = $digit = 9;
    }

    0 <= $hour-new\ .Int < 24 or error( qq[Invalid hour "$hour-orig"]     );
    0 <= $minute-new.Int < 60 or error( qq[Invalid minute "$minute-orig"] );

    return $digit;
}

#------------------------------------------------------------------------------
sub input-is-valid( Str:D $time --> Bool:D )
#------------------------------------------------------------------------------
{
    return False unless $time.chars == 5;
    return False unless $time.substr( 2, 1 ) eq ':';

    my UInt $count = 0;

    for 0, 1, 3, 4 -> UInt $i
    {
        my Str $c = $time.substr: $i, 1;

        return False unless $c ~~ / ^ <[ 0..9 ? ]> $ /;

        ++$count if $c eq '?';
    }

    return $count == 1;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $time, $expected) =
                $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        is find-highest-digit( $time ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, ?5:00, 1
        Example 2, ?3:00, 2
        Example 3, 1?:00, 9
        Example 4, 2?:00, 3
        Example 5, 12:?5, 5
        Example 6, 12:5?, 9
        END
}

###############################################################################
