#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two square coordinates are entered on the command-line. Each has the form
   "FR", where F is the file ('a' .. 'h'), and R is the rank (1 .. 8).

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <c1> <c2>
  perl $0

    <c1>    First  chessboard square coordinate (file & rank)
    <c2>    Second chessboard square coordinate (file & rank)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 376, Task #1: Chessboard Squares (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my  ($c1, $c2) = @ARGV;

        for ($c1, $c2)
        {
            / ^ [a-h] [1-8] $ /x or error( qq["$_ is not a valid coordinate"] );
        }

        print qq[Input:  \$c1 = "$c1", \$c2 = "$c2"\n];

        my $same_colour = same_colour( $c1, $c2 );

        printf "Output: %s\n", $same_colour ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub same_colour
#-------------------------------------------------------------------------------
{
    my ($c1, $c2) = @_;
    my  $c1nums   = coord2nums( $c1 );
    my  $c2nums   = coord2nums( $c2 );

    return ($c1nums->[0] + $c1nums->[1]) % 2 ==
           ($c2nums->[0] + $c2nums->[1]) % 2;
}

#-------------------------------------------------------------------------------
sub coord2nums
#-------------------------------------------------------------------------------
{
    my ($coord) =  @_;
        $coord  =~ / ^ ([a-h]) ([1-8]) $ /x or die 'Error, stopped';

    return [ (ord( $1 ) - ord( 'a' ) + 1), $2 ];
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $c1, $c2, $expected) = split / \| /x, $line;

        for ($test_name, $c1, $c2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $same_colour = same_colour( $c1, $c2 ) ? 'true' : 'false';

        is $same_colour, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1  |a7|f4|true
Example 2  |c1|e8|false
Example 3  |b5|h2|false
Example 4  |f3|h1|true
Example 5  |a1|g8|false
Same square|e4|e4|true
