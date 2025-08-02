use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 289
=========================

TASK #1
-------
*Third Maximum*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the third distinct maximum in the given array. If third
maximum doesn't exist then return the maximum number.

Example 1

  Input: @ints = (5, 6, 4, 1)
  Output: 4

  The first distinct maximum is 6.
  The second distinct maximum is 5.
  The third distinct maximum is 4.

Example 2

  Input: @ints = (4, 5)
  Output: 5

  In the given array, the third maximum doesn't exist therefore returns the
  maximum.

Example 3

  Input: @ints =  (1, 2, 2, 3)
  Output: 1

  The first distinct maximum is 3.
  The second distinct maximum is 2.
  The third distinct maximum is 1.

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
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 289, Task #1: Third Maximum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    # Change IntStr to Int and normalize

    my Array[Int] $ints = Array[Int].new: @ints.map: { .Int };

    "Input:  \@ints = (%s)\n".printf: $ints.join: ', ';

    my Int $third-max = find-third-max( $ints );

    "Output: $third-max".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-third-max( List:D[Int:D] $ints where { .elems > 0 } --> Int:D )
#-------------------------------------------------------------------------------
{
    my UInt %count{Int};
          ++%count{ $_ } for @$ints;

    my Int  @sorted = %count.keys.sort: { $^b <=> $^a };
    my UInt $index  = @sorted.elems >= 3 ?? 2 !! 0;

    return  @sorted[ $index ];
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

        my Int @ints      = $ints-str.split( / \s+ / ).map: { .Int };
        my Int $third-max = find-third-max( @ints );

        is $third-max, $expected.Int, $test-name;
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
        Example 1| 5 6 4 1| 4
        Example 2| 4 5    | 5
        Example 3| 1 2 2 3| 1
        Singleton|42      |42
        END
}

################################################################################
