use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 376
=========================

TASK #1
-------
*Chessboard Squares*

Submitted by: Mohammad Sajid Anwar

You are given two coordinates of a square on 8x8 chessboard.

Write a script to find the given two coordinates have the same colour.

  8 W B W B W B W B
  7 B W B W B W B W
  6 W B W B W B W B
  5 B W B W B W B W
  4 W B W B W B W B
  3 B W B W B W B W
  2 W B W B W B W B
  1 B W B W B W B W
    a b c d e f g h

Example 1

  Input: $c1 = "a7", $c2 = "f4"
  Output: true

Example 2

  Input: $c1 = "c1", $c2 = "e8"
  Output: false

Example 3

  Input: $c1 = "b5", $c2 = "h2"
  Output: false

Example 4

  Input: $c1 = "f3", $c2 = "h1"
  Output: true

Example 5

  Input: $c1 = "a1", $c2 = "g8"
  Output: false

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
2. Two square coordinates are entered on the command-line. Each has the form
   "FR", where F is the file ('a' .. 'h'), and R is the rank (1 .. 8).

=end comment
#===============================================================================

use Test;

subset Coord of Str where * ~~ / ^ <[ a .. h ]> <[ 1 .. 8 ]> $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 376, Task #1: Chessboard Squares (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Coord:D $c1,      #= First  chessboard square coordinate (file & rank)
    Coord:D $c2       #= Second chessboard square coordinate (file & rank)
)
#===============================================================================
{
    qq[Input:  \$c1 = "$c1", \$c2 = "$c2"].put;

    my Bool $same-colour = same-colour( $c1, $c2 );

    "Output: %s\n".printf: $same-colour ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub same-colour( Coord:D $c1, Coord:D $c2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt @c1 = coord2nums( $c1 );
    my UInt @c2 = coord2nums( $c2 );

    return (@c1[0] + @c1[1]) % 2 == (@c2[0] + @c2[1]) % 2;
}

#-------------------------------------------------------------------------------
sub coord2nums( Coord:D $coord --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    $coord ~~ / ^ (<[ a .. h ]>) (<[ 1 .. 8 ]>) $ / or die 'Error, stopped';

    return ($0.ord - 'a'.ord + 1), (~$1).Int;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $c1, $c2, $expected) = $line.split: '|';

        for     $test-name, $c1, $c2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $same-colour = same-colour( $c1, $c2 ) ?? 'true' !! 'false';

        is $same-colour, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1  |a7|f4|true
        Example 2  |c1|e8|false
        Example 3  |b5|h2|false
        Example 4  |f3|h1|true
        Example 5  |a1|g8|false
        Same square|e4|e4|true
        END
}

################################################################################
