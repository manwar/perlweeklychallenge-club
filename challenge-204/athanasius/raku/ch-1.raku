use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 204
=========================

TASK #1
-------
*Monotonic Array*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given array is Monotonic. Print 1 if it is
otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

  Monotone increasing: for i <= j , nums[i] <= nums[j]
  Monotone decreasing: for i <= j , nums[i] >= nums[j]

Example 1

  Input: @nums = (1,2,2,3)
  Output: 1

Example 2

  Input: @nums (1,3,2)
  Output: 0

Example 3

  Input: @nums = (6,5,5,4)
  Output: 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first argument is negative, it must be preceded by "--" to distin-
   guish it from a command-line flag.

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 204, Task #1: Monotonic Array (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| A list of 1 or more integers

    *@nums where { .elems >= 1 && .all ~~ Int:D }
)
#==============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ',';

    "Output: %d\n".printf: is-monotonic( @nums ) ?? 1 !! 0;
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub is-monotonic( List:D[Int:D] $nums --> Bool:D )
#------------------------------------------------------------------------------
{
    enum Dir < Flat Up Down >;

    my Dir $dir  = Flat;
    my Int $last = $nums[ 0 ];

    for 1 .. $nums.end -> UInt $i
    {
        my Int $next = $nums[ $i ];

        if    $next > $last
        {
            return False if $dir == Down;

            $dir = Up;
        }
        elsif $next < $last
        {
            return False if $dir == Up;

            $dir = Down;
        }

        $last = $next;
    }

    return True;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        my Int  @nums = $input.split( / \, \s* / ).map: { .Int };
        my UInt $got  = is-monotonic( @nums ) ?? 1 !! 0;

        is $got, $expected.Int, $test-name;
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
        Example 1  | 1, 2, 2, 3          |1
        Example 2  | 1, 3, 2             |0
        Example 3  | 6, 5, 5, 4          |1
        Flat       | 4, 4, 4, 4          |1
        Negatives 1|-1,-1,-2,-2,-4,-5    |1
        Negatives 2|-1,-1,-2,-2,-4,-3    |0
        Single     |42                   |1
        Mixed 1    |-5,-2, 0, 0, 1, 3,5,5|1
        Mixed 2    |-5,-2,-3,-1, 0, 4,6  |0
        END
}

###############################################################################
