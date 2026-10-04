use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 393
=========================

TASK #1
-------
*Pythagoras Multiplied*

Submitted by: Ulrich Rieke

You are given a positive integer n.

Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2 =
c^2 and a, b and c are integers <= n.

Example 1

  Input: $n = 20
  Output: 12

  (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
  (8,6,10), (8,15,17), (9,12,15),(12,5,13),
  (12,9,15),(12,16,20),(15,8,17),(16,12,20)

Example 2

  Input: $n = 7
  Output: 2

  (3,4,5),(4,3,5)

Example 3

  Input: $n = 1
  Output: 0

Example 4

  Input: $n = 15
  Output: 8

Example 5

  Input: $n = 30
  Output: 22

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A positive integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 393, Task #1: Pythagoras Multiplied (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n                       #= A positive integer
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    my UInt $triplets = count-triplets( $n );

    qq[Output: $triplets].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-triplets( UInt:D $n --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $triplets = 0;

    if $n >= 5
    {
        my UInt @squares = (1 .. $n).map: { $_² };

        for 0 .. @squares.end - 2 -> UInt $i
        {
            my UInt $square-i = @squares[$i];

            for $i + 1 .. @squares.end - 1 -> UInt $j
            {
                my UInt $sum = $square-i + @squares[$j];

                last if $sum > @squares[ *-1 ];

                $triplets += 2 if $sum ∈ @squares;
            }
        }
    }

    return $triplets;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) = $line.split: '|';

        for     $test-name, $n, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $triplets = count-triplets( $n.Int );

        is $triplets, $expected.Int, $test-name;
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
        Example 1|20|12
        Example 2| 7| 2
        Example 3| 1| 0
        Example 4|15| 8
        Example 5|30|22
        END
}

################################################################################
