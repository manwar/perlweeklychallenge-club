use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 357
=========================

TASK #1
-------
*Kaprekar Constant*

Submitted by: Mohammad Sajid Anwar

Write a function that takes a 4-digit integer and returns how many iterations
are required to reach Kaprekar's constant (6174). For more information about
Kaprekar's Constant please follow the [https://en.wikipedia.org/wiki/6174
|wikipedia page].

Example 1

  Input: $int = 3524
  Output: 3

  Iteration 1: 5432 - 2345 = 3087
  Iteration 2: 8730 - 0378 = 8352
  Iteration 3: 8532 - 2358 = 6174

Example 2

  Input: $int = 6174
  Output: 0

Example 3

  Input: $int = 9998
  Output: 5

  Iteration 1: 9998 - 8999 = 0999
  Iteration 2: 9990 - 0999 = 8991
  Iteration 3: 9981 - 1899 = 8082
  Iteration 4: 8820 - 0288 = 8532
  Iteration 5: 8532 - 2358 = 6174

Example 4

  Input: $int = 1001
  Output: 4

  Iteration 1: 1100 - 0011 = 1089
  Iteration 2: 9810 - 0189 = 9621
  Iteration 3: 9621 - 1269 = 8352
  Iteration 4: 8532 - 2358 = 6174

Example 5

  Input: $int = 9000
  Output: 4

  Iteration 1: 9000 - 0009 = 8991
  Iteration 2: 9981 - 1899 = 8082
  Iteration 3: 8820 - 0288 = 8532
  Iteration 4: 8532 - 2358 = 6174

Example 6

  Input: $int = 1111
  Output: -1

  The sequence does not converge on 6174, so return -1.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input integer must contain exactly 4 digits, but leading zeros are allowed.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-negative 4-digit integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

my UInt constant KAPREKAR   = 6174;
my UInt constant MAX-ITERS  =    7;
my UInt constant NUM-DIGITS =    4;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 357, Task #1: Kaprekar Constant (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D $int where { / ^ \d\d\d\d $ / }      #= A non-negative 4-digit integer
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my Int $iterations = count-iterations( $int );

    "Output: $iterations".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-iterations( Int:D $int where { / ^ \d\d\d\d $ / } --> Int:D )
#-------------------------------------------------------------------------------
{
    my UInt @digits = $int.split( '', :skip-empty ).map: { .Int };
    @digits.unshift: 0 until @digits.elems == NUM-DIGITS;

    return -1 if @digits[0] == @digits[1 .. NUM-DIGITS - 1].all;

    my Int  $count     = 0;
    my UInt $iteration = $int;

    until $iteration == KAPREKAR
    {
        my UInt $max = @digits.sort.reverse.join.Int;
        my UInt $min = @digits.sort.        join.Int;
        $iteration   = $max - $min;

        die 'ERROR: count too large' if ++$count > MAX-ITERS;

        @digits = $iteration.split( '', :skip-empty ).map: { .Int };
        @digits.unshift: 0 until @digits.elems == NUM-DIGITS;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $expected) = $line.split: / \| /;

        for     $test-name, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int $iterations = count-iterations( $int.Int );

        is $iterations, $expected.Int, $test-name;
    }

    done-testing;
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
        Example 1|3524| 3
        Example 2|6174| 0
        Example 3|9998| 5
        Example 4|1001| 4
        Example 5|9000| 4
        Example 6|1111|-1
        Wikipedia|2111| 5
        Max iters|2005| 7
        END
}

################################################################################
