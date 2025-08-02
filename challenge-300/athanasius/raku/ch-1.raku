use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 300
=========================

TASK #1
-------
*Beautiful Arrangement*

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can con-
struct.

  A permutation of n integers, 1-indexed, is considered a beautiful arrangement
  if for every i (1 <= i <= n) either of the following is true:

  1) perm[i] is divisible by i
  2) i is divisible by perm[i]

Example 1

  Input: $n = 2
  Output: 2

  1st arrangement: [1, 2]
      perm[1] is divisible by i = 1
      perm[2] is divisible by i = 2
  2nd arrangement: [2, 1]
      perm[1] is divisible by i = 1
      i=2 is divisible by perm[2] = 1

Example 2

  Input: $n = 1
  Output: 1

Example 3

  Input: $n = 10
  Output: 700

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
2. A positive integer is entered on the command-line.

Reference
---------
"A320843: Number of permutations sigma of {1,2,...,n} such that sigma(i) divides
i or i divides sigma(i) for 1 <= i <= n.", The Online Encyclopedia of Integer
Sequences, https://oeis.org/A320843

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 300, Task #1: Beautiful Arrangement (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n where * > 0                 #= A positive integer
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my UInt  $beautiful = count-beautiful-arrangements( $n );

    "Output: $beautiful".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-beautiful-arrangements( UInt:D $n where * > 0 --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $count = 0;

    L-OUTER:
    for (1 .. $n).permutations -> @perm
    {
        # Start at $i = 1, because $i = 0 => $j = 1, and X %% 1 is always true

        for 1 .. @perm.end -> $i
        {
            my $j = $i + 1;

            next L-OUTER unless @perm[ $i ] %% $j || $j %% @perm[ $i ];
        }

        ++$count;
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
        my Str ($test-name, $n-str, $expected) = $line.split: / \| /;

        for     $test-name, $n-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $beautiful = count-beautiful-arrangements( $n-str.Int );

        is $beautiful, $expected.Int, $test-name;
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
        Example 1| 2|  2
        Example 2| 1|  1
        Example 3|10|700
        END
}

################################################################################
