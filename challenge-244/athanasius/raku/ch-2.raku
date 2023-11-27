use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 244
=========================

TASK #2
-------
*Group Hero*

Submitted by: Mohammad S Anwar

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations;
power is defined as the square of the largest number in a sequence, multiplied
by the smallest.

Example 1

  Input: @nums = (2, 1, 4)
  Output: 141

  Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
  Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
  Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
  Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
  Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
  Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
  Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

  Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Duplicates are allowed in the input list.
2. Combinations are unordered and unique, but may contain duplicates. So, (1, 2)
   and (2, 1) are the same combination, BUT (1, 2) and (1, 2, 2) are different
   combinations (and so must be counted separately).

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 244, Task #2: Group Hero (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@nums where { .elems > 0 && .all ~~ Int:D }           #= A list of integers
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';

    my Int $sum = power-sum( @nums );

    "Output: $sum".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub power-sum( List:D[Int:D] $nums --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int %groups{Set[Int]};

    for $nums.combinations: 1 .. * -> List $comb
    {
        my $set = Set[Int].new: $comb.map: { .Int };

        %groups{ $set } = power( $set );
    }

    my UInt %counts{Int};
          ++%counts{ $_ } for @$nums;

    my Int $sum = 0;

    for %groups.keys -> Set[Int] $comb
    {
        my UInt $multiplier = 1;

        for %counts.keys -> Int $num
        {
            $multiplier *= %counts{ $num } if $num.Int ∈ $comb;
        }

        $sum += %groups{ $comb } * $multiplier;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub power( Set:D[Int:D] $comb --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int @nums = $comb.keys;
    my Int $max  = @nums.max;
    my Int $min  = @nums.min;

    return $max² * $min;
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

        my Int @nums = $nums-str.split( / \s+ / ).map: { .Int };
        my Int $sum  = power-sum( @nums );

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
        Example 1  |2 1 4      |141
        Multiples 1|1 1 2 2    | 34
        Multiples 2|2 1 4 1 2 1|315
        END
}

################################################################################
