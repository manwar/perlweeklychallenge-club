use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 286
=========================

TASK #2
-------
*Order Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

Example 1

  Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
  Output: 1

  Operation 1:

      min(2, 1) = 1
      max(4, 5) = 5
      min(6, 3) = 3
      max(0, 2) = 2

  Operation 2:

      min(1, 5) = 1
      max(3, 2) = 3

  Operation 3:

      min(1, 3) = 1

Example 2

  Input: @ints = (0, 5, 3, 2)
  Output: 0

  Operation 1:

      min(0, 5) = 0
      max(3, 2) = 3

  Operation 2:

      min(0, 3) = 0

Example 3

  Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
  Output: 2

  Operation 1:

      min(9, 2) = 2
      max(1, 4) = 4
      min(5, 6) = 5
      max(0, 7) = 7
      min(3, 1) = 1
      max(3, 5) = 5
      min(7, 9) = 7
      max(0, 8) = 8

  Operation 2:

      min(2, 4) = 2
      max(5, 7) = 7
      min(1, 5) = 1
      max(7, 8) = 8

  Operation 3:

      min(2, 7) = 2
      max(1, 8) = 8

  Operation 4:

      min(2, 8) = 2

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
2. A non-empty list of integers is entered on the command-line. The length of
   the list must be a power of two.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 286, Task #2: Order Game (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers whose length is a power of 2

    *@ints where { .all ~~ Int:D && .elems > 0 && is-power-of-two( .elems ) }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Int $last-element = play-order-game( @ints );

    "Output: $last-element".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub play-order-game( List:D[Int:D] $ints --> Int:D )
#-------------------------------------------------------------------------------
{
    my Int @ints = @$ints;

    while @ints.elems > 1
    {
        my Int ($lhs, $rhs, @temp);

        while @ints
        {
            $lhs = @ints.shift;
            $rhs = @ints.shift;

            @temp.push: ($lhs, $rhs).min;

            if @ints
            {
                $lhs = @ints.shift;
                $rhs = @ints.shift;

                @temp.push: ($lhs, $rhs).max;
            }
        }

        @ints = @temp;
    }

    return @ints[ 0 ];
}

#-------------------------------------------------------------------------------
sub is-power-of-two( UInt:D $n --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int $log = ($n.log2 + 0.5).floor;

    return 2 ** $log == $n;
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

        my Int @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Int $last = play-order-game( @ints );

        is $last, $expected.Int, $test-name;
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
        Example 1| 2 1  4 5 6 3 0 2                | 1
        Example 2| 0 5  3 2                        | 0
        Example 3| 9 2  1 4 5 6 0 7 3 1 3 5 7 9 0 8| 2
        Singleton|42                               |42
        Negatives|-9 0 -1 5                        |-9
        END
}

################################################################################
