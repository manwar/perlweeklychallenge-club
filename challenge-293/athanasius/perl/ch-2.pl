#!perl

################################################################################
=comment

Perl Weekly Challenge 293
=========================

TASK #2
-------
*Boomerang*

Submitted by: Mohammad Sajid Anwar

You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

    A boomerang is a set of three points that are all distinct and not in a
    straight line.

Example 1

  Input: @points = ( [1, 1], [2, 3], [3, 2] )
  Output: true

Example 2

  Input: @points = ( [1, 1], [2, 2], [3, 3] )
  Output: false

Example 3

  Input: @points = ( [1, 1], [1, 2], [2, 3] )
  Output: true

Example 4

  Input: @points = ( [1, 1], [1, 2], [1, 3] )
  Output: false

Example 5

  Input: @points = ( [1, 1], [2, 1], [3, 1] )
  Output: false

Example 6

  Input: @points = ( [0, 0], [2, 3], [4, 5] )
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The points are located on a Cartesian plane, and their x- and y-coordinates are
integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 6 integers is entered on the command-line. These are pairs of co-
   ordinates defining 3 points on the Cartesian plane.

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use List::MoreUtils qw( natatime );
use Regexp::Common  qw( number );
use Test::More;

const my $EPSILON => 1e-12;
const my $USAGE   => <<END;
Usage:
  perl $0 [<coords> ...]
  perl $0

    [<coords> ...]    A list of 6 integers defining 3 points on a plane

END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 293, Task #2: Boomerang (Perl)\n\n";
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
    elsif ($argc == 6)
    {
        my @coords = @ARGV;

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @coords;

        my $it = natatime 2, @coords;
        my @points;

        while (my @pair = $it->())
        {
            push @points, [ @pair ];
        }

        printf "Input:  \@points = ( %s )\n",
                join ', ', map { sprintf '[%d, %d]', @$_ } @points;

        my $boomerang = boomerang( \@points );

        printf "Output: %s\n", $boomerang ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 6 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub boomerang
#-------------------------------------------------------------------------------
{
    my ($points)   = @_;
    my  $boomerang = 1;

    if (equal_points( $points->[ 0 ], $points->[ 1 ] ) ||   # Not distinct
        equal_points( $points->[ 0 ], $points->[ 2 ] ) ||
        equal_points( $points->[ 1 ], $points->[ 2 ] ))
    {
        $boomerang = 0;
    }
    elsif ($points->[ 0 ][ 0 ] == $points->[ 1 ][ 0 ])      # Vertical
    {
        $boomerang = 0 if $points->[ 0 ][ 0 ] == $points->[ 2 ][ 0 ];
    }
    elsif ($points->[ 0 ][ 1 ] == $points->[ 1 ][ 1 ])      # Horizontal
    {
        $boomerang = 0 if $points->[ 0 ][ 1 ] == $points->[ 2 ][ 1 ];
    }
    else                                                    # Diagonal
    {
        my $m1 = ($points->[ 1 ][ 1 ] - $points->[ 0 ][ 1 ]) /
                 ($points->[ 1 ][ 0 ] - $points->[ 0 ][ 0 ]);

        my $m2 = ($points->[ 2 ][ 1 ] - $points->[ 0 ][ 1 ]) /
                 ($points->[ 2 ][ 0 ] - $points->[ 0 ][ 0 ]);

        if (equal_floats( $m1, $m2 ))                       # Slopes are equal
        {
            my $b1 = $points->[ 1 ][ 1 ] - $m1 * $points->[ 1 ][ 0 ];
            my $b2 = $points->[ 2 ][ 1 ] - $m2 * $points->[ 2 ][ 0 ];

            $boomerang = 0 if equal_floats( $b1, $b2 );     # y-intercepts equal
        }
    }

    return $boomerang;
}

#-------------------------------------------------------------------------------
sub equal_points
#-------------------------------------------------------------------------------
{
    my ($p1, $p2) = @_;

    return ($p1->[ 0 ] == $p2->[ 0 ]) &&
           ($p1->[ 1 ] == $p2->[ 1 ]);
}

#-------------------------------------------------------------------------------
sub equal_floats
#-------------------------------------------------------------------------------
{
    my ($f, $g) = @_;

    return abs( $f - $g ) < $EPSILON;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $coords_str, $expected) = split / \| /x, $line;

        for ($test_name, $coords_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @strings   = split / \; /x, $coords_str;
        my @points    = map { [ grep { length > 0 } split / \s+ /x ] } @strings;
        my $boomerang = boomerang( \@points ) ? 'true' : 'false';

        is $boomerang, $expected, $test_name;
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
Example 1     |1  1; 2 3;  3 2|true
Example 2     |1  1; 2 2;  3 3|false
Example 3     |1  1; 1 2;  2 3|true
Example 4     |1  1; 1 2;  1 3|false
Example 5     |1  1; 2 1;  3 1|false
Example 6     |0  0; 2 3;  4 5|true
Horizontal 1  |4  7; 0 7; -5 7|false
Horizontal 2  |4  7; 0 7; -5 6|true
Vertical 1    |4 -1; 4 8;  4 0|false
Vertical 2    |4 -1; 4 8;  3 0|true
Equal slopes 1|1  1; 2 3;  3 5|false
Equal slopes 2|1  1; 2 3;  3 6|true
