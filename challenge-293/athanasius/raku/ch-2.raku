use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The points are located on a Cartesian plane, and their x- and y-coordinates are
integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 6 integers is entered on the command-line. These are pairs of co-
   ordinates defining 3 points on the Cartesian plane.
3. If the first integer is negative, it must be preceded by "--" to prevent it
   from being interpreted as a command-line flag.

=end comment
#===============================================================================

use Test;

subset Point of List where (Int, Int);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 293, Task #2: Boomerang (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 6 integers defining 3 points on a plane

    *@coords where { .elems == 6 && .all ~~ Int:D }
)
#===============================================================================
{
    my Point  @points = @coords.map( { .Int } ).batch( 2 );

    "Input:  \@points = ( %s )\n".printf:
              @points.map( { '[%d, %d]'.sprintf: @$_ } ).join: ', ';

    my Bool $boomerang = boomerang( @points );

    "Output: %s\n".printf: $boomerang ?? 'true' !! 'false'
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub boomerang( List:D[Point:D] $points where { .elems == 3 } --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool $boomerang = True;

    if equal-points( $points[ 0 ], $points[ 1 ] ) ||   # Not distinct
       equal-points( $points[ 0 ], $points[ 2 ] ) ||
       equal-points( $points[ 1 ], $points[ 2 ] )
    {
        $boomerang = False;
    }
    elsif $points[ 0; 0 ] == $points[ 1; 0 ]            # Vertical
    {
        $boomerang = False if $points[ 0; 0 ] == $points[ 2; 0 ];
    }
    elsif $points[ 0; 1 ] == $points[ 1; 1 ]            # Horizontal
    {
        $boomerang = False if $points[ 0; 1 ] == $points[ 2; 1 ];
    }
    else                                                # Diagonal
    {
        my Rat $m1 = ($points[ 1; 1 ] - $points[ 0; 1 ]) /
                     ($points[ 1; 0 ] - $points[ 0; 0 ]);

        my Rat $m2 = ($points[ 2; 1 ] - $points[ 0; 1 ]) /
                     ($points[ 2; 0 ] - $points[ 0; 0 ]);

        if $m1 == $m2                                   # Slopes are equal
        {
            my Rat $b1 = $points[ 1; 1 ] - $m1 * $points[ 1; 0 ];
            my Rat $b2 = $points[ 2; 1 ] - $m2 * $points[ 2; 0 ];

            $boomerang = False if $b1 == $b2;           # y-intercepts are equal
        }
    }

    return $boomerang;
}

#-------------------------------------------------------------------------------
sub equal-points( Point:D $p1, Point:D $p2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    return ($p1[ 0 ] == $p2[ 0 ]) &&
           ($p1[ 1 ] == $p2[ 1 ]);
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $coords-str, $expected) = $line.split: / \| /;

        for     $test-name, $coords-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str   @point-strs = $coords-str.split: / \; /;
        my Point @points     = @point-strs.map:
                 { .split( / \s+ /, :skip-empty ).map( { .Int } ).list };
        my Str   $boomerang  = boomerang( @points ) ?? 'true' !! 'false';

        is $boomerang, $expected, $test-name;
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
        END
}

################################################################################
