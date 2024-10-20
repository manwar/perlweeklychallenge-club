use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 291
=========================

TASK #1
-------
*Middle Index*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst
all the possible ones.

    A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] ==
    ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

  If MI == 0, the left side sum is considered to be 0. Similarly,
  if MI == ints.length - 1, the right side sum is considered to be 0.

Return the leftmost MI that satisfies the condition, or -1 if there is no such
index.

Example 1

  Input: @ints = (2, 3, -1, 8, 4)
  Output: 3

  The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
  The sum of the numbers after index 3 is: 4 = 4

Example 2

  Input: @ints = (1, -1, 4)
  Output: 2

  The sum of the numbers before index 2 is: 1 + -1 = 0
  The sum of the numbers after index 2 is: 0

Example 3

  Input: @ints = (2, 5)
  Output: -1

  There is no valid MI.

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
    "\nChallenge 291, Task #1: Middle Index (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    qq[Input:  \@ints = (%s)\n].printf: @ints.join: ', ';

    my Int $m-idx = find-middle-index( @ints );

    "Output: $m-idx".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-middle-index( List:D[Int:D] $ints where { .elems > 0 } --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int $left-sum   = 0;
    my Int $right-sum  = 0;
           $right-sum += $ints[ $_ ] for 1 .. $ints.end;

    for 0 .. $ints.end - 1 -> UInt $i
    {
        return $i if $left-sum == $right-sum;

        $left-sum  += $ints[ $i     ];
        $right-sum -= $ints[ $i + 1 ];
    }

    return $left-sum == 0 ?? $ints.end !! -1;
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

        my Int @ints  = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $m-idx = find-middle-index( @ints );

        is $m-idx, $expected.Int, $test-name;
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
        Example 1|2  3 -1 8 4| 3
        Example 2|1 -1  4    | 2
        Example 3|2  5       |-1
        Left  idx|5 -2 -3 0 5| 0
        Right idx|6 -4 -3 1 7| 4
        END
}

################################################################################
