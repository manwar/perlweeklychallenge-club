use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 388
=========================

TASK #2
-------
*Secret Santa*

Submitted by: Roger Bell_West

A company with $n employees is running a Secret Santa exchange. Each employee
buys one gift and receives one gift.

Write a script to return the total number of valid gift assignments where no
employee receives the gift they originally bought (i.e., employee $i must not be
assigned gift $i).

Example 1

  Input: $n = 1
  Output: 0

  Only 1 participant exists. They would have to receive their own gift, which is
  invalid.

Example 2

  Input: $n = 2
  Output: 1

  Participants 1 and 2 must swap gifts ([2, 1]).

Example 3

  Input: $n = 3
  Output: 2

  The 2 valid gift arrays where array[i] is who person i+1 receives from:
  [2, 3, 1]
  [3, 1, 2]

Example 4

  Input: $n = 4
  Output: 9

  The 9 valid arrays are:
  [2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
  [3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
  [4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],

Example 5

  Input: $n = 5
  Output: 44

  There are 44 valid permutations out of 5! = 120 total possible arrangements.

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
2. The number of employees is entered on the command-line.

Note
----
"[A] permutation of the elements of a set in which no element appears in its
original position" is a derangement or subfactorial [2]. Beginning with n = 0,
the number of derangements of a set of size n are as follows:

  1, 0, 1, 2, 9, 44, 265, 1854, 14833, 133496, 1334961, ... [1], [2]

Let D_n be the number of derangements of a set of n elements. Then one formula
for D_n is the following [2]:

  D_n = ⎣ n!/𝑒 + ½ ⎦

where ⎣x⎦ is the lower bound (floor) of x, n! is n factorial, and 𝑒 is Euler's
number.

References
----------
[1] "A000166 Subfactorial or rencontres numbers, or derangements...", _OEIS_,
    https://oeis.org/A000166
[2] "Derangement", _Wikipedia_, https://en.wikipedia.org/wiki/Derangement

=end comment
#===============================================================================

use Lingua::EN::Numbers;
use Test;

# Note: Raku's inbuilt term 𝑒 has insufficient precision for the required calcu-
#       lations

my Rat constant E = 2.7182818284590452353602874713527;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 388, Task #2: Secret Santa (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n                      #= Number of employees
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my UInt $assignments = count-assignments( $n );

    "Output: %s\n".printf: comma( $assignments );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-assignments( UInt:D $n --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $assignments = 1;

    if $n > 0
    {
        $assignments = ((factorial( $n ).FatRat / E) + 0.5).floor;
    }

    return $assignments;
}

#-------------------------------------------------------------------------------
sub factorial( UInt:D $n --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $factorial = 1;

    if $n > 1
    {
        $factorial *= $_ for 2 .. $n;
    }

    return $factorial;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) = $line.split: '|';

        for     $test-name, $n, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $assignments = count-assignments( $n.Int );

        is $assignments, $expected.Int, $test-name;
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
        Example 1| 1|                            0
        Example 2| 2|                            1
        Example 3| 3|                            2
        Example 4| 4|                            9
        Example 5| 5|                           44
        Zero     | 0|                            1
        Larger n |23|9_510_425_471_055_777_937_262
        END
}

################################################################################
