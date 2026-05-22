use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 374
=========================

TASK #2
-------
*Largest Same-digits Number*

Submitted by: Mohammad Sajid Anwar

You are given a string containing 0-9 digits only.

Write a script to return the largest number with all digits the same in the
given string.

Example 1

  Input: $str = "6777133339"
  Output: 3333

Example 2

  Input: $str = "1200034"
  Output: 4

Example 3

  Input: $str = "44221155"
  Output: 55

Example 4

  Input: $str = "88888"
  Output: 88888

Example 5

  Input: $str = "11122233"
  Output: 222

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. "The largest number with all digits the same in the given string" means: the
   largest number represented by a substring of *contiguous* identical digits.
   For example, for the string "9199", the answer is 99.
2. If the string consists of zero digits only, the answer is 0 regardless of how
   many digits are in the string.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single, non-empty string, containing digits (0-9) only, is entered on the
   command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 374, Task #2: Largest Same-digits Number (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str where / ^ <[ 0 .. 9 ]>+ $ /       #= A non-empty string of digits
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my UInt $num = find-largest-num( $str );

    "Output: $num".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-largest-num( Str:D $str where / ^ <[ 0 .. 9 ]>+ $ / --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt @digits  = $str.split( '', :skip-empty ).map: { .Int };
    my UInt $current = @digits.shift;
    my UInt @candidates;

    for @digits -> UInt $digit
    {
        if $digit == $current % 10
        {
            $current *= 10;
            $current += $digit;
        }
        else
        {
            @candidates.push: $current;
            $current = $digit;
        }
    }

    @candidates.push: $current;

    return @candidates.max;
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

        my UInt $num = find-largest-num( $str );

        is $num, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|6777133339|3333
        Example 2|1200034   |4
        Example 3|44221155  |55
        Example 4|88888     |88888
        Example 5|11122233  |222
        END
}

################################################################################
