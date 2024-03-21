use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 261
=========================

TASK #1
-------
*Element Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to evaluate the absolute difference between element and digit sum
of the given array.

Example 1

  Input: @ints = (1,2,3,45)
  Output: 36

  Element Sum: 1 + 2 + 3 + 45 = 51
  Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
  Absolute Difference: | 51 - 15 | = 36

Example 2

  Input: @ints = (1,12,3)
  Output: 9

  Element Sum: 1 + 12 + 3 = 16
  Digit Sum: 1 + 1 + 2 + 3 = 7
  Absolute Difference: | 16 - 7 | = 9

Example 3

  Input: @ints = (1,2,3,4)
  Output: 0

  Element Sum: 1 + 2 + 3 + 4 = 10
  Digit Sum: 1 + 2 + 3 + 4 = 10
  Absolute Difference: | 10 - 10 | = 0

Example 4

  Input: @ints = (236, 416, 336, 350)
  Output: 1296

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more integers are given as arguments on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

Assumption
----------
For the purpose of calculating the digit sum, only digits 1 to 9 and 0 are used:
the signs "+" and "-" are ignored. However, negative numbers remain negative for
the purpose of calculating the element sum.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 261, Task #1: Element Digit Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ',';

    my UInt $diff = find-difference( @ints );

    "Output: $diff".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-difference( List:D[Int:D] $ints where { .elems > 0 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Int  $element-sum = [+] @$ints;
    my UInt $digit-sum   = 0;

    for @$ints -> Int $element
    {
        for $element.split( '', :skip-empty ).grep: { / ^ \d $/ }
        {
            $digit-sum += $_;
        }
    }

    return ($element-sum - $digit-sum).abs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $diff = find-difference( @ints );

        is $diff, $expected.Int, $test-name;
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
        Example 1|  1   2   3  45|  36
        Example 2|  1  12   3    |   9
        Example 3|  1   2   3   4|   0
        Example 4|236 416 336 350|1296
        Signed   | -1 +34  -2  +2|  21
        END
}

################################################################################
