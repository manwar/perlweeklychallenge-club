use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 284
=========================

TASK #1
-------
*Lucky Integer*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there
are more than one then return the largest.

    A lucky integer is an integer that has a frequency in the array equal to its
    value.

Example 1

  Input: @ints = (2, 2, 3, 4)
  Output: 2

Example 2

  Input: @ints = (1, 2, 2, 3, 3, 3)
  Output: 3

Example 3

  Input: @ints = (1, 1, 1, 3)
  Output: -1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Negative integers are excluded.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 284, Task #1: Lucky Integer (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of unsigned (i.e., non-negative) integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    my Int @ints_ = @ints;             # Make a copy, then
           @ints_.map: { $_ += 0 };    # Normalize the elements (e.g., +5 --> 5)

    "Input:  \@ints = (%s)\n".printf: @ints_.join: ', ';

    my Int $lucky-int = find-lucky-int( @ints_ );

    "Output: $lucky-int".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-lucky-int( List:D[UInt:D] $ints --> Int:D )
#-------------------------------------------------------------------------------
{
    my UInt %freq{UInt};
          ++%freq{ $_ } for @$ints;

    # "If there are more than one [lucky number] then return the largest." To
    # accomplish this, the elements are tested in reverse order (highest first).

    for @$ints.sort: { $^b <=> $^a } -> UInt $n
    {
        return $n if $n == %freq{ $n };
    }

    return -1;
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
        my Int $lucky-int = find-lucky-int( @ints );

        is $lucky-int, $expected.Int, $test-name;
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
        Example 1     |2 2 3 4    | 2
        Example 2     |1 2 2 3 3 3| 3
        Example 3     |1 1 1 3    |-1
        Ex 2 reordered|3 3 3 2 2 1| 3
        END
}

################################################################################
