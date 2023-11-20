use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 243
=========================

TASK #2
-------
*Floor Sum*

Submitted by: Mohammad S Anwar

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j <
nums.length. The floor() function returns the integer part of the division.

Example 1

  Input: @nums = (2, 5, 9)
  Output: 10

  floor(2 / 5) = 0
  floor(2 / 9) = 0
  floor(5 / 9) = 0
  floor(2 / 2) = 1
  floor(5 / 5) = 1
  floor(9 / 9) = 1
  floor(5 / 2) = 2
  floor(9 / 2) = 4
  floor(9 / 5) = 1

Example 2

  Input: @nums = (7, 7, 7, 7, 7, 7, 7)
  Output: 49

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * >= 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 243, Task #2: Floor Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of positive integers (>= 1)

    *@nums where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';

    my Pos $sum = floor-sum( @nums );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub floor-sum( List:D[Pos:D] $nums --> Pos:D )
#-------------------------------------------------------------------------------
{
    my Pos $sum = Nil;

    for 0 .. $nums.end -> UInt $i
    {
        for 0 .. $nums.end -> UInt $j
        {
            $sum += ($nums[ $i ] / $nums[ $j ]).floor;
        }
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $nums-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos @nums = $nums-str.split( / \s+ / ).map: { .Int };
        my Pos $sum  = floor-sum( @nums );

        is $sum, $exp-str.Int, $test-name;
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
        Example 1|2 5 9               | 10
        Example 2|7 7 7 7 7 7 7       | 49
        Series   |1 2 3 4 5 6 7 8 9 10|127
        END
}

################################################################################
