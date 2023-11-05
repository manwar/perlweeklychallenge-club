use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 241
=========================

TASK #1
-------
*Arithmetic Triplets*

Submitted by: Mohammad S Anwar

You are given an array (3 or more members) of integers in increasing order and a
positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying
the following rules:

  a) i < j < k
  b) nums[j] - nums[i] == diff
  c) nums[k] - nums[j] == diff

Example 1

  Input: @nums = (0, 1, 4, 6, 7, 10)
         $diff = 3
  Output: 2

  Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 ==
  3.
  Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 ==
  3.

Example 2

  Input: @nums = (4, 5, 6, 7, 8, 9)
         $diff = 2
  Output: 2

  (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
  (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

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
2. If VERBOSE is set to True, the required output is followed by a list of the
   arithmetic triplets found.
3. If the first (non-difference) integer is negative, it must be preceded by
   "--" to indicate that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 241, Task #1: Arithmetic Triplets (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D :$diff,                                    #= Difference (integer > 0)
    *@nums where { .elems >= 3      &&               #= A list of 3 or more
                   .all   ~~ Int:D  &&               #=   integers
                   increasing-order( @nums ) }       #=   in increasing order
)
#===============================================================================
{
    "Input:  \@nums = (%s)\n".printf: @nums.join: ', ';
    "        \$diff = $diff".put;

    my Array[UInt] @triplets = find-triplets( @nums, $diff );

    my UInt $count = @triplets.elems;

    "Output: $count".put;

    if VERBOSE && $count > 0
    {
        "\nArithmetic triplet%s: %s\n".printf:
            $count == 1 ?? '' !! 's',
            @triplets.map( { '(' ~ @$_.join( ', ' ) ~ ')' } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-triplets
(
    List:D[Int:D] $nums,     #= A list of 3 or more integers in increasing order
    Pos:D         $diff      #= The target difference
--> List:D[List:D[UInt:D]]   #= A list of the arithmetic triplets found
)
#-------------------------------------------------------------------------------
{
    my Array[UInt] @triplets;

    L-OUTER: for 0 .. $nums.end - 2 -> UInt $i
    {
        for $i + 1 .. $nums.end - 1 -> UInt $j
        {
            if (my UInt $ji-diff = $nums[ $j ] - $nums[ $i ]) == $diff
            {
                for $j + 1 .. $nums.end -> $k
                {
                    if (my UInt $kj-diff = $nums[ $k ] - $nums[ $j ]) == $diff
                    {
                        @triplets.push: Array[UInt].new: $i, $j, $k;
                        next L-OUTER;
                    }
                    elsif $kj-diff > $diff
                    {
                        next L-OUTER;
                    }
                }
            }
            elsif $ji-diff > $diff
            {
                next L-OUTER;
            }
        }
    }

    return @triplets;
}

#-------------------------------------------------------------------------------
sub increasing-order( List:D[Int:D] $nums --> Bool:D )
#-------------------------------------------------------------------------------
{
    for 1 .. $nums.end -> UInt $i
    {
        return False unless $nums[ $i ] > $nums[ $i - 1 ];
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num-str, $diff, $expected) = $line.split: / \| /;

        for     $test-name, $num-str, $diff, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int         @nums     = $num-str.split( / \s+ / ).map: { .Int };
        my Array[UInt] @triplets = find-triplets( @nums, $diff.Int );

        is @triplets.elems, $expected.Int, $test-name;
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
        Example 1| 0  1  4 6 7 10      |3|2
        Example 2| 4  5  6 7 8  9      |2|2
        Negatives|-5 -4 -1 0 1  3 4 5 7|4|3
        END
}

################################################################################
