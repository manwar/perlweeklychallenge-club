use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 333
=========================

TASK #1
-------
*Straight Line*

Submitted by: Mohammad Sajid Anwar

You are given a list of co-ordinates.

Write a script to find out if the given points make a straight line.

Example 1

  Input: @list = ([2, 1], [2, 3], [2, 5])
  Output: true

Example 2

  Input: @list = ([1, 4], [3, 4], [10, 4])
  Output: true

Example 3

  Input: @list = ([0, 0], [1, 1], [2, 3])
  Output: false

Example 4

  Input: @list = ([1, 1], [1, 1], [1, 1])
  Output: true

Example 5

  Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of coordinate strings is entered on the command-line.
3. If the first coordinate string begins with a hyphen (because the x-coordin-
   ate is negative), it must be preceded by "--" to indicate that it is not a
   command-line flag.

Assumptions
-----------
1. The coordinates represent points on the Cartesian plane; therefore, coordin-
   ate values are real numbers.
2. Degenerate cases: if there are only 1 or 2 (distinct) coordinates, they are
   deemed to be collinear.

Note
----
The difficulties of equality comparison using floating-point arithmetic (see the
Perl solution to this Task) are here avoided by representing real number co-
ordinate values as instances of the built-in Raku class Rat.

=end comment
#===============================================================================

use Test;

subset Coord of List where (Rat, Rat);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 333, Task #1: Straight Line (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@list        #= A non-empty list of co-ordinate strings (e.g., "1 2" "3 4")
)
#===============================================================================
{
    my Coord @coords = get-coords( @list );

    "Input:  \@list = (%s)\n".printf:
              @coords.map( { '[' ~ .join( ', ' ) ~ ']' } ).join: ', ';

    my Bool $collinear = are-collinear( @coords );

    "Output: %s\n".printf: $collinear ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub are-collinear( List:D[Coord:D] $list --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Coord @coords = remove-duplicates( $list );

    if @coords.elems > 2
    {
        my Rat $x0 =  @coords[ 0; 0 ];
        my Rat $y0 =  @coords[ 0; 1 ];
        my Rat $x1 =  @coords[ 1; 0 ];
        my Rat $y1 =  @coords[ 1; 1 ];
        my Rat $m0 = ($x0 == $x1) ?? Rat !! ($y1 - $y0) / ($x1 - $x0);

        for 2 .. @coords.end -> UInt $i
        {
            my Rat $xi  = @coords[ $i; 0 ];
            my Rat $yi  = @coords[ $i; 1 ];
            my Rat $lhs = $xi;                     # Assume the line is vertical
            my Rat $rhs = $x0;

            if $m0.defined                         # It's not
            {
                $lhs = ($yi - $y0) / ($xi - $x0);
                $rhs =  $m0;
            }

            return False unless $lhs == $rhs;
        }
    }

    return True;
}

#-------------------------------------------------------------------------------
sub remove-duplicates( List:D[Coord:D] $list --> List:D[Coord:D] )
#-------------------------------------------------------------------------------
{
    my Coord @unique;

    for @$list -> Coord $coord
    {
        my Bool $found = False;

        for @unique -> Coord $uniq
        {
            if equal( $uniq, $coord )
            {
                $found = True;
                last;
            }
        }

        @unique.push: $coord unless $found;
    }

    return @unique;
}

#-------------------------------------------------------------------------------
sub equal( Coord:D $p, Coord:D $q --> Bool:D )
#-------------------------------------------------------------------------------
{
    return $p[ 0 ] == $q[ 0 ] && $p[ 1 ] == $q[ 1 ];
}

#-------------------------------------------------------------------------------
sub get-coords( List:D[Str:D] $list --> List:D[Coord:D] )
#-------------------------------------------------------------------------------
{
    my Coord @coords;

    for @$list -> Str $str
    {
        my Str @pair = $str.split: / \s+ /, :skip-empty;

        @pair.elems == 2 or error( qq[Invalid coordinate string "$str"] );

        for @pair
        {
            .Rat         // error( qq["$_" is not a valid coordinate value] );
        }

        @coords.push: [ @pair.map: { .Rat } ];
    }

    return @coords;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $coord-str, $expected) = $line.split: / \| /;

        for     $test-name, $coord-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Coord @coords    = get-coords( [ $coord-str.split: ';' ] );
        my Str   $collinear = are-collinear( @coords ) ?? 'true' !! 'false';

        is $collinear, $expected, $test-name;
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
        Example 1  | 2 1; 2 3;  2 5                                  |true
        Example 2  | 1 4; 3 4; 10 4                                  |true
        Example 3  | 0 0; 1 1;  2 3                                  |false
        Example 4  | 1 1; 1 1;  1 1                                  |true
        Example 5  |1000000 1000000; 2000000 2000000; 3000000 3000000|true
        Duplicate 1| 1 2; 1 2;  2 3; 3 4                             |true
        Duplicate 2| 1 2; 1 2;  2 3; 3 5                             |false
        Duplicate 3| 1 2; 1 2;  2 3; 1 2                             |true
        Singleton  | 4 9                                             |true
        Pair       | 4 9; 7 6                                        |true
        Reals      |-1.5 0.3; -2.5 -0.7; -3.5 -1.7                   |true
        END
}

################################################################################
