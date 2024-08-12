#!perl

################################################################################
=comment

Perl Weekly Challenge 281
=========================

TASK #1
-------
*Check Color*

Submitted by: Mohammad Sajid Anwar

You are given coordinates, a string that represents the coordinates of a square
of the chessboard as shown below:

  8 │ │╳│ │╳│ │╳│ │╳│
  7 │╳│ │╳│ │╳│ │╳│ │
  6 │ │╳│ │╳│ │╳│ │╳│
  5 │╳│ │╳│ │╳│ │╳│ │
  4 │ │╳│ │╳│ │╳│ │╳│
  3 │╳│ │╳│ │╳│ │╳│ │
  2 │ │╳│ │╳│ │╳│ │╳│
  1 │╳│ │╳│ │╳│ │╳│ │
     a b c d e f g h

  Week_281_Task_1

Write a script to return true if the square is light, and false if the square is
dark.

Example 1

  Input: $coordinates = "d3"
  Output: true

Example 2

  Input: $coordinates = "g5"
  Output: false

Example 3

  Input: $coordinates = "e6"
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input coordinates are entered as a single, two-character string on the
   command-line.

Algorithm
---------
Let the files "a" through "h" be numbered 1 through 8. Then, by inspection, the
dark squares occur where the file and rank are either both odd or both even.
Conversely, the light squares occur where either the file is odd and the rank is
even, or the file is even and the rank is odd.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use utf8;
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <coordinates>
  perl $0

    <coordinates>    Coordinates identifying a chessboard square, e.g., "d3"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 281, Task #1: Check Color (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        my $coordinates = $ARGV[ 0 ];

        $coordinates =~ / ^ [a-h] [1-8] $ /x
            or error( qq[Invalid coordinates "$coordinates"] );

        print qq[Input:  \$coordinates = "$coordinates"\n];

        my $is_light = square_is_light( $coordinates );

        printf "Output: %s\n", $is_light ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub square_is_light
#-------------------------------------------------------------------------------
{
    my ($coordinates)   = @_;
    my ($file_s, $rank) = split //, $coordinates;
    my  $file           = ord( $file_s ) - ord( 'a' ) + 1;
    my  $file_is_even   = $file % 2 == 0;
    my  $rank_is_even   = $rank % 2 == 0;

    return $file_is_even ? !$rank_is_even
                         :  $rank_is_even;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $coords, $expected) = split / \| /x, $line;

        for ($test_name, $coords, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $is_light = square_is_light( $coords );

        is $is_light, $expected eq 'true', $test_name;
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
Example 1|d3|true
Example 2|g5|false
Example 3|e6|true
