use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 294
=========================

TASK #2
-------
*Next Permutation*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find out the next permutation of the given array.

    The next permutation of an array of integers is the next lexicographically
    greater permutation of its integer.

Example 1

  Input: @ints = (1, 2, 3)
  Output: (1, 3, 2)

  Permutations of (1, 2, 3) arranged lexicographically:
  (1, 2, 3)
  (1, 3, 2)
  (2, 1, 3)
  (2, 3, 1)
  (3, 1, 2)
  (3, 2, 1)

Example 2

  Input: @ints = (2, 1, 3)
  Output: (2, 3, 1)

Example 3

  Input: @ints = (3, 1, 2)
  Output: (3, 2, 1)

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
2. A list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.

Assumption
----------
Repetitions are allowed in the input list.

Algorithm
---------
From [1]: "The following algorithm generates the next permutation lexicographi-
cally after a given permutation. It changes the given permutation in-place.

   "1. Find the largest index k such that a[k] < a[k + 1]. If no such index
       exists, the permutation is the last permutation.
   "2. Find the largest index l greater than k such that a[k] < a[l].
   "3. Swap the value of a[k] with that of a[l].
   "4. Reverse the sequence from a[k + 1] up to and including the final element
       a[n]."

Reference
---------
[1] https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 294, Task #2: Next Permutation (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int @next = find-next-perm( @ints );

    if @next.elems > 0
    {
        "Output:         (%s)\n"\.printf: @next.join: ', ';
    }
    else
    {
        'Output: This is the last permutation'.put;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-next-perm( List:D[Int:D] $ints --> List:D[Int:D] )
#-------------------------------------------------------------------------------
{
    # 1. Find the largest index k such that a[k] < a[k + 1]. If no such index
    #    exists, the permutation is the last permutation.

    my Int $k = -1;

    for (0 .. $ints.end - 1).reverse -> UInt $i
    {
        $k = $i, last if $ints[ $i ] < $ints[ $i + 1 ];
    }

    return () if $k < 0;

    # 2. Find the largest index l greater than k such that a[k] < a[l]

    my UInt $l;

    for ($k + 1 .. $ints.end).reverse -> UInt $i
    {
        $l = $i, last if $ints[ $k ] < $ints[ $i ];
    }

    my Int @next = @$ints;

    # 3. Swap the value of a[k] with that of a[l]

    @next[ $k, $l ] = @next[ $l, $k ];

    # 4. Reverse the sequence from a[k + 1] up to and including the final
    #    element a[n]

    @next[ $k + 1 .. * ] = @next[ $k + 1 .. * ].reverse;

    return @next;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @next = find-next-perm( @ints );
        my Int @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @next, @expd, $test-name;
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
        Example 1| 1  2  3| 1  3  2
        Example 2| 2  1  3| 2  3  1
        Example 3| 3  1  2| 3  2  1
        Inc 1st 1| 1  3  2| 2  1  3
        Inc 1st 2| 2  3  1| 3  1  2
        Negatives|-2 -1 -3|-1 -3 -2
        Last perm| 3  2  1|
        END
}

################################################################################
