use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 201
=========================

TASK #2
-------
*Penny Piles*

Submitted by: Robbie Hatley

You are given an integer, $n > 0.

Write a script to determine the number of ways of putting $n pennies in a row
of piles of ascending heights from left to right.

Example

  Input: $n = 5
  Output: 7

  Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:

      1 1 1 1 1
      1 1 1 2
      1 2 2
      1 1 3
      2 3
      1 4
      5

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line argument is given, the test suite is run.

Output Order
------------
Following the Example, partitions are ordered by number of piles, descending.
Partitions with the same number of piles are ordered by the size (height) of
the largest pile, ascending. Within each partition, piles are ordered by size,
ascending.

Solution
--------
The required solution is given by the partition function [1], an integer
sequence [2] for which "No closed-form expression ... is known" but for which
there are "recurrence relations by which it can be calculated exactly." [1]

The solution implemented below uses recursion based on Euler's recurrence
relation [1: "Recurrence relations"]. The required calculation time increases
markedly as n increases.

References
----------
[1] "Partition function (number theory)", Wikipedia,
     https://en.wikipedia.org/wiki/Partition_function_(number_theory)
[2]  Sequence A000041, The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A000041

=end comment
#==============================================================================

use Test;

subset Pos of Int where * > 0;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 201, Task #2: Penny Piles (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Pos:D $n                       #= A positive integer
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    "Output: %d\n".printf: count-penny-piles( $n );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub count-penny-piles( Int:D $n --> Int:D )
#------------------------------------------------------------------------------
{
    # From [1: "Recurrence relations"]:
    #
    # p(n) = ∑ (-1)^(k + 1) × p(n - k(3k - 1)/2)
    #      k∊Z\{0}
    #
    # Base cases: p(0) = 1
    #             p(k) = 0 for all negative k
    #
    # k:    √(24n + 1) - 1       √(24n + 1) + 1
    #     - -------------- ≤ k ≤ --------------
    #             6                    6

    return 0 if $n <  0;
    return 1 if $n == 0;

    my Num $root        = ((24 * $n) + 1).sqrt;
    my Int $lower-bound = (-($root - 1) / 6).ceiling;
    my Int $upper-bound = ( ($root + 1) / 6).floor;
    my Int $p           = 0;

    for $lower-bound .. $upper-bound -> Int $k
    {
        next if $k == 0;

        $p += ((-1) ** ($k + 1)).Int *
              count-penny-piles( $n - (($k * (3 * $k - 1)) / 2).Int );
    }

    return $p;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) =
                $line.split: / \| /, $TEST-FIELDS;

        my UInt $count = count-penny-piles( $n.Int );

        is $count, $expected, $test-name;
    }

    done-testing;
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
        Example | 5|7
        Smallest| 1|1
        Small   |13|101
        Medium  |22|1002
        END
}

###############################################################################
