use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 378
=========================

TASK #1
-------
*Second Largest Digit*

Submitted by: Mohammad Sajid Anwar

You are given an alphanumeric string.

Write a script to find the second largest distinct digit in the given string.
Return -1 if none found.

Example 1

  Input: $str = "aaaaa77777"
  Output: -1

  The only digit in the given string is 7 and there is no second digit.

Example 2

  Input: $str = "abcde"
  Output: -1

  No numerical digits in the given string.

Example 3

  Input: $str = "9zero8eight7seven9"
  Output: 8

Example 4

  Input: $str = "xyz9876543210"
  Output: 8

Example 5

  Input: $str = "4abc4def2ghi8jkl2"
  Output: 4

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An alphanumeric string is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Result of Int where 9 > * >= -1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 378, Task #1: Second Largest Digit (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                    #= An alphanumeric string
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my Result $digit = find-digit( $str );

    "Output: $digit".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-digit( Str:D $str --> Result:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict{UInt};

    for $str.split( '', :skip-empty ) -> Str $char
    {
        ++%dict{ $char.Int } if $char ~~ / ^ <[ 0 .. 9 ]> $ /;
    }

    my UInt @digits = %dict.keys.sort;

    return @digits.elems >= 2 ?? @digits[ *-2 ] !! -1;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: '|';

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Result $digit = find-digit( $str );

        is $digit, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|aaaaa77777        |-1
        Example 2|abcde             |-1
        Example 3|9zero8eight7seven9| 8
        Example 4|xyz9876543210     | 8
        Example 5|4abc4def2ghi8jkl2 | 4
        END
}

################################################################################
