use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 237
=========================

TASK #2
-------
*Maximise Greatness*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to permute the given array such that you get the maximum possible
greatness.

    To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length

Example 1

  Input: @nums = (1, 3, 5, 2, 1, 3, 1)
  Output: 4

  One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as
  below:
  nums[0] < perm[0]
  nums[1] < perm[1]
  nums[3] < perm[3]
  nums[4] < perm[4]

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: 3

  One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
  nums[0] < perm[0]
  nums[1] < perm[1]
  nums[2] < perm[2]

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
2. If the first element in the input list is negative, it must be preceded by
   "--" to distinguish it from a command-line flag.
3. If VERBOSE is set to True (the default), the output is followed by details of
   one possible permutation which gives the maximum greatness.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 237, Task #2: Maximise Greatness (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@nums where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@nums =  (%s)\n".printf: @nums.join: ', ';

    my (UInt $max, Array[Int] $perm) = find-max-greatness( @nums );

    "Output: $max".put;

    "\nOne permutation: (%s)\n".printf: $perm.join: ', ' if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-greatness( List:D[Int:D] $nums --> List:D[UInt:D, List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my UInt $max  = 0;
    my Int  @from = $nums.sort;
    my Int  @to   = @from;
    my Int  @perm = Nil xx $nums.elems;

    while @from
    {
        my Int $from = @from.pop;
        my Int $to;

        if @to[ *-1 ] > $from
        {
            $to = @to.pop;
            ++$max;
        }
        else
        {
            $to = @to.shift;
        }

        for 0 .. $nums.end -> UInt $i
        {
            next if @perm[ $i ].defined;

            if $nums[ $i ] == $from
            {
                @perm[ $i ] = $to;
                last;
            }
        }
    }

    return $max, @perm;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $num-str, $exp, $exp-str) = $line.split: / \| /;

        for     $test-name, $num-str, $exp, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @nums = $num-str.split( / \s+ / ).map: { .Int };
        my Int @exp  = $exp-str.split( / \s+ / ).map: { .Int };

        my (UInt $max, Array[Int] $perm) = find-max-greatness( @nums );

        is        $max,  $exp.Int, $test-name ~ ': maximum greatness';
        is-deeply $perm, @exp,     $test-name ~ ': permutation';
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
        Example 1| 1  3  5  2 1  3 1|4| 3  5  1  3 2  1  1
        Example 2| 1  2  3  4       |3| 2  3  4  1
        Negatives|-1 -2 -3 -4       |3|-4 -1 -2 -3
        Mixed    | 0 -1  1 -2 2 -3 3|6| 1  0  2 -1 3 -2 -3
        END
}

################################################################################
