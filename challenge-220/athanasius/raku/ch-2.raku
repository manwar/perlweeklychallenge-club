use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 220
=========================

TASK #2
-------
*Squareful*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

    An array is squareful if the sum of every pair of adjacent elements is a
    perfect square.

Write a script to find all the permutations of the given array that are square-
ful.

Example 1:

  Input: @ints = (1, 17, 8)
  Output: (1, 8, 17), (17, 8, 1)

  (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect
             square too.
  (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect
             square too.

Example 2:

  Input: @ints = (2, 2, 2)
  Output: (2, 2, 2)

  There is only one permutation possible.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first command-line argument is negative, it must be preceded by "--".

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 220, Task #2: Squareful (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Array[Int] @perms = find-squareful-permutations( @ints );

    "Output: %s\n".printf:
                  @perms.map( { '(' ~ .join( ', ' ) ~ ')' } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-squareful-permutations( List:D[Int:D] $ints --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @perms;

    for $ints.sort.permutations -> List $perm-list
    {
        my Int @perm-array = Array[Int].new: |$perm-list;

        @perms.push: @perm-array unless @perm-array eqv @perms.any;
    }

    my Array[Int] @squareful-perms = Array[Array[Int]].new;

    L-OUTER:
    for @perms -> Array[Int] $perm
    {
        for 0 .. $perm.end - 1 -> UInt $i
        {
            my Int $sum = $perm[ $i ] + $perm[ $i + 1 ];

            next L-OUTER unless ($sum.sqrt)² == $sum;
        }

        @squareful-perms.push: $perm;
    }

    return @squareful-perms;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $ints-str, @expected-strs) = $line.split: / \| /;

        for $name, $ints-str, @expected-strs                   # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int        @ints     = $ints-str.split( / \s+ / ).map: { .Int };
        my Array[Int] @perms    = find-squareful-permutations( @ints );
        my Array[Int] @expected;

        for @expected-strs
        {
            my Str @ints = .split: / \s+ /;

            @expected.push: Array[Int].new( |@ints.map: { .Int } )
                if @ints.elems > 0 && @ints[ 0 ].chars > 0;
        }

        is-deeply @perms, @expected, $name;
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
        Example 1   |1 17  8|1  8 17|17  8 1
        Example 2   |2  2  2|2  2  2
        No solution |1  0  2|
        Negative    |5 10 -1|5 -1 10|10 -1 5
        Out-of-order|8 17  1|1  8 17|17  8 1
        END
}

################################################################################
