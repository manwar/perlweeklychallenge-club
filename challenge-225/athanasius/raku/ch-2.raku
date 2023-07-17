use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 225
=========================

TASK #2
-------
*Left Right Sum Diff*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to return left right sum diff array as shown below:

  @ints = (a, b, c, d, e)

  @left  = (0, a, (a+b), (a+b+c))
  @right = ((c+d+e), (d+e), e, 0)
  @left_right_sum_diff = ( | 0 - (c+d+e) |,
                           | a - (d+e)   |,
                           | (a+b) - e   |,
                           | (a+b+c) - 0 | )

Example 1:

  Input: @ints = (10, 4, 8, 3)
  Output: (15, 1, 11, 22)

  @left  = (0, 10, 14, 22)
  @right = (15, 11, 3, 0)

  @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
                       = (15, 1, 11, 22)

Example 2:

  Input: @ints = (1)
  Output: (0)

  @left  = (0)
  @right = (0)

  @left_right_sum_diff = ( |0-0| ) = (0)

Example 3:

  Input: @ints = (1, 2, 3, 4, 5)
  Output: (14, 11, 6, 1, 10)

  @left  = (0, 1, 3, 6, 10)
  @right = (14, 12, 9, 5, 0)

  @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
                       = (14, 11, 6, 1, 10)

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
2. It $VERBOSE is set to True, the required output (the left-right-sum-diff
   array) is followed by the left and right arrays.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 225, Task #2: Left Right Sum Diff (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:   \@ints = (%s)\n".printf: @ints.join: ', ';

    my Array[Int] %solution = find-left-right-sum-diff( @ints );

    "Output:  (%s)\n".printf: %solution< lrsd >.join: ', ';

    if $VERBOSE
    {
        "\n\@left  = (%s)\n".printf: %solution< left  >.join: ', ';
          "\@right = (%s)\n".printf: %solution< right >.join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-left-right-sum-diff( List:D[Int:D] $ints --> Hash:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my UInt $end   = $ints.end;
    my Int  @left  = 0;
    my Int  @right = 0;
    my Int  @lrsd;

    @left\[ $_ ] = @left\[ $_ - 1 ] + $ints[        $_ - 1 ] for 1 .. $end;
    @right[ $_ ] = @right[ $_ - 1 ] + $ints[ $end - $_ + 1 ] for 1 .. $end;
    @right      .= reverse;
    @lrsd\[ $_ ] = (@left[ $_ ] - @right[ $_ ]).abs          for 0 .. $end;

    return my Array[Int] %{Str} = :left(@left), :right(@right), :lrsd(@lrsd);
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $left-str, $rght-str, $lrsd-str) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $left-str, $rght-str, $lrsd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @left = $left-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @rght = $rght-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int @lrsd = $lrsd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        my Array[Int] %solution = find-left-right-sum-diff( @ints );

        is-deeply %solution< left  >, @left, "$test-name: left";
        is-deeply %solution< right >, @rght, "$test-name: right";
        is-deeply %solution< lrsd  >, @lrsd, "$test-name: left-right-sum-diff";
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
        Example 1| 10 4  8   3|  0 10 14 22|   15 11   3 0|   15  1 11 22
        Example 2|           1|           0|             0|             0
        Example 3|1 2 3  4   5|0 1  3  6 10|14 12  9   5 0|14 11  6  1 10
        Negatives|    6 -4 -12|     0  6  2|     -16 -12 0|      16 18  2
        END
}

################################################################################
