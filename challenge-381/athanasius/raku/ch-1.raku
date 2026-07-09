use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 381
=========================

TASK #1
-------
*Same Row Column*

Submitted by: Mohammad Sajid Anwar

You are given a n x n matrix containing integers from 1 to n.

Write a script to find if every row and every column contains all the integers
from 1 to n.

Example 1

  Input: @matrix = ([1, 2, 3, 4],
                    [2, 3, 4, 1],
                    [3, 4, 1, 2],
                    [4, 1, 2, 3],)
  Output: true

Example 2

  Input: @matrix = ([1])
  Output: true

Example 3

  Input: @matrix = ([1, 2, 5],
                    [5, 1, 2],
                    [2, 5, 1],)
  Output: false

  Elements are out of range 1..3.

Example 4

  Input: @matrix = ([1, 2, 3],
                    [1, 2, 3],
                    [1, 2, 3],)
  Output: false

Example 5

  Input: @matrix = ([1, 2, 3],
                    [3, 1, 2],
                    [3, 2, 1],)
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
2. The input matrix is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        ⎡1 2 3 4⎤
        ⎢2 3 4 1⎥
        ⎢3 4 1 2⎥
        ⎣4 1 2 3⎦

   is entered as: >raku ch-1.raku "1 2 3 4" "2 3 4 1" "3 4 1 2" "4 1 2 3"

Note
----
Matrix-handling code is adapted from the solution to Task 2 for Week 266.

=end comment
#===============================================================================

use Test;

subset Matrix of Array where * ~~ Array[Array[Int]];

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 381, Task #1: Same Row Column (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A square and non-empty integer matrix

    *@matrix where { .all ~~ Str:D && .elems > 0 }
)
#===============================================================================
{
    my Matrix $matrix = parse-matrix( @matrix );

    print-matrix( 'Input:  $matrix = ', $matrix );

    my Bool $same = same-row-col( $matrix );

    "Output: %s\n".printf: $same ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub same-row-col( Matrix:D $matrix --> Bool:D )
#-------------------------------------------------------------------------------
{
    for 0 .. $matrix.end -> UInt $row
    {
        my Int @row = |$matrix[ $row ];

        return False unless is-full( @row );

        my Int @col;

        for 0 .. $matrix.end -> UInt $col
        {
            @col.push: $matrix[ $col; $row ];
        }

        return False unless is-full( @col );
    }

    return True;
}

#-------------------------------------------------------------------------------
sub is-full( List:D[Int:D] $list --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Int @target = 1 .. $list.elems;
    my Int @sorted = $list.sort;

    return @target eqv @sorted;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[Str:D] $rows --> Matrix:D )
#-------------------------------------------------------------------------------
{
    my Matrix $matrix = Array[Array[Int]].new;
    my UInt   $cols;

    for @$rows -> Str $row-str
    {
        my Int @row;

        for $row-str.split( / \s+ /, :skip-empty ) -> Str $elem
        {
            if +$elem ~~ Int:D
            {
                @row.push: +$elem;
            }
            else
            {
                error( qq[Element "$elem" is not a valid integer] );
            }
        }

        @row.elems > 0 or error( 'Empty row' );
        $matrix.push: @row;

        if $cols.defined
        {
            @row.elems == $cols  or error( 'The input matrix is ragged' );
        }
        else    # Initialize $cols
        {
            $cols =  @row.elems;
            $cols == $rows.elems or error( 'The input matrix is not square' );
        }
    }

    return $matrix;
}

#-------------------------------------------------------------------------------
sub print-matrix( Str:D $prefix, Matrix:D $matrix )
#-------------------------------------------------------------------------------
{
    if $matrix.elems == 1
    {
        "$prefix\[%d]\n".printf: $matrix[ 0; 0 ];
    }
    else
    {
        my Str  $tab   = ' ' x $prefix.chars;
        my UInt @width = 1  xx $matrix[ 0 ].elems;

        for @$matrix -> Int @row
        {
            for 0 .. @row.end -> UInt $i
            {
                my UInt $w   = @row[ $i ].chars;
                @width[ $i ] = $w if $w > @width[ $i ];
            }
        }

        "%s⎡%s⎤\n".printf: $prefix, format-row( @width, $matrix[  0  ] );

        "%s⎢%s⎥\n".printf: $tab,    format-row( @width, $matrix[  $_ ] )
            for 1 .. $matrix.end - 1;

        "%s⎣%s⎦\n".printf: $tab,    format-row( @width, $matrix[ *-1 ] );
    }
}

#-------------------------------------------------------------------------------
sub format-row( List:D[UInt:D] $width, List:D[Int:D] $row --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @row-str;

    for 0 .. $row.end -> UInt $i
    {
        @row-str.push: '%*d'.sprintf: $width[ $i ], $row[ $i ];
    }

    return @row-str.join: ' ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $expected) = $line.split: '|';

        for     $test-name, $matrix-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str    @rows   = $matrix-str.split: / \; /, :skip-empty;
        my Matrix $matrix = parse-matrix( @rows );
        my Str    $same   = same-row-col( $matrix ) ?? 'true' !! 'false';

        is $same, $expected, $test-name;
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
        Example 1|1 2 3 4; 2 3 4 1; 3 4 1 2; 4 1 2 3|true
        Example 2|1                                 |true
        Example 3|1 2 5;   5 1 2;   2 5 1           |false
        Example 4|1 2 3;   1 2 3;   1 2 3           |false
        Example 5|1 2 3;   3 1 2;   3 2 1           |false
        END
}

################################################################################
