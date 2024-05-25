use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 270
=========================

TASK #2
-------
*Equalize Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

  Level 1:
  Pick an index i of the given array and do $ints[i] += 1

  Level 2:
  Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.

You are allowed to perform as many levels as you want to make every elements in
the given array equal. There is cost attached for each level, for Level 1, the
cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

Example 1

  Input: @ints = (4, 1), $x = 3 and $y = 2
  Output: 9

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 2)

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 3)

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 4)

  We performed operation Level 1, 3 times.
  So the total cost would be 3 x $x => 3 x 3 => 9

Example 2

  Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
  Output: 6

  Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
  @ints = (3, 4, 3, 3, 5)

  Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
  @ints = (4, 4, 4, 3, 5)

  Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
  @ints = (5, 4, 4, 4, 5)

  Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
  @ints = (5, 5, 5, 4, 5)

  Level 1: i=3, so $ints[3] += 1
  @ints = (5, 5, 5, 5, 5)

  We performed operation Level 1, 1 time and Level 2, 4 times.
  So the total cost would be (1 x $x) + (3 x $y) => (1 x 2) + (4 x 1) => 6

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Costs cannot be negative.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The costs $x and $y are entered as named arguments on the command-line,
   followed by the elements of @ints; e.g.

        raku ch-2.raku -x=3 -y=2 4 1

3. If the first element of @ints is a negative number, it must be preceded by
   "--" to prevent it from being interpreted as a command-line flag; e.g.

        raku ch-2.raku -x=5 -y=3 -- -1 -2 -3 -6

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 270, Task #2: Equalize Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D :$x,                                  #= Cost of Level 1 option
    UInt:D :$y,                                  #= Cost of Level 2 option
    *@ints where { .elems > 0 && .all ~~ Int:D } #= List of one or more integers
)
#===============================================================================
{
    "Input:  \@ints = (%s), \$x = %d and \$y = %d\n".printf:
              @ints.join( ', ' ), $x, $y;

    my UInt $cost = find-min-cost( @ints, $x, $y );

    "Output: $cost".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-cost( List:D[Int:D] $ints, UInt:D $x, UInt:D $y --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $cost = 0;

    if $x > 0     # Otherwise array can be equalized with all Level 1 at no cost
    {
        my Int @ints = @$ints;              # Make a copy
        my Int $max  = $ints.max;

        if $y < 2 * $x       # Otherwise Level 2 gives no advantage over Level 1
        {
            # First, apply Level 2 as often as possible

            L-OUTER:
            for 0 .. @ints.end - 1 -> UInt $i
            {
                for $i + 1 .. @ints.end -> UInt $j
                {
                    if @ints[ $i ] < $max && @ints[ $j ] < $max
                    {
                        ++@ints[ $i ];
                        ++@ints[ $j ];

                        $cost += $y;

                        redo L-OUTER;
                    }
                }
            }
        }

        # Now complete array equalization with Level 1

        $cost += ($max - $_) * $x for @ints;
    }

    return $cost;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $x-str, $y-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $x-str, $y-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $cost = find-min-cost( @ints, $x-str.Int, $y-str.Int );

        is $cost, $expected-str.Int, $test-name;
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
        Example 1| 4  1        |3|2| 9
        Example 2| 2  3  3  3 5|2|1| 6
        Zero x   | 2  3  3  3 5|0|1| 0
        Zero y   | 2  3  3  3 5|7|0| 7
        Uniform  | 4  4  4  4  |2|1| 0
        Negatives|-1 -2 -3 -6  |5|3|26|     # 2×3 + 4×5
        Singleton|17           |3|2| 0
        END
}

################################################################################
