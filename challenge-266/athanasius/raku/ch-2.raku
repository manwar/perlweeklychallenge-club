use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 266
=========================

TASK #2
-------
*X Matrix*

Submitted by: Mohammad Sajid Anwar

You are given a square matrix, $matrix.

Write a script to find if the given matrix is X Matrix.

    A square matrix is an X Matrix if all the elements on the main diagonal and
    antidiagonal are non-zero and everything else are zero.

Example 1

  Input: $matrix = [ [1, 0, 0, 2],
                     [0, 3, 4, 0],
                     [0, 5, 6, 0],
                     [7, 0, 0, 1],
                   ]
  Output: true

Example 2

  Input: $matrix = [ [1, 2, 3],
                     [4, 5, 6],
                     [7, 8, 9],
                   ]
  Output: false

Example 3

  Input: $matrix = [ [1, 0, 2],
                     [0, 3, 0],
                     [4, 0, 5],
                   ]
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
Matrix elements are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input matrix is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        [ 1 1 0 ]
        [ 0 1 0 ]
        [ 0 0 0 ]

    is entered as: >raku ch-2.raku "1 1 0" "0 1 0" "0 0 1"

Note
----
Matrix-handling code is adapted from the solutions to Task 2 for Week 248 and
Task 2 for Week 257.

=end comment
#===============================================================================

use Test;

subset Matrix of Array where * ~~ Array[Array[Int]];

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 266, Task #2: X Matrix (Raku)\n".put;
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

    my Bool $x-matrix = is-x-matrix( $matrix );

    "Output: %s\n".printf: $x-matrix ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-x-matrix( Matrix:D $matrix --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $end = $matrix.end;

    for 0 .. $end -> UInt $row
    {
        for 0 .. $end -> UInt $col
        {
            if $row        == $col ||          # On the main diagonal
               $row + $col == $end             # On the antidiagonal
            {
                return False if     $matrix[ $row; $col ] == 0;
            }
            else
            {
                return False unless $matrix[ $row; $col ] == 0;
            }
        }
    }

    return True;
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
    my Str  $tab   = ' ' x $prefix.chars;
    my UInt @width = 1  xx $matrix[ 0 ].elems;

    for @$matrix -> Int @row
    {
        for 0 .. @row.end -> UInt $i
        {
            my UInt $w = @row[ $i ].chars;

            @width[ $i ] = $w if $w > @width[ $i ];
        }
    }

    "$prefix\[".put;

    for @$matrix -> Int @row
    {
        my Str @row-str;

        for 0 .. @row.end -> UInt $i
        {
            @row-str.push: '%*d'.sprintf: @width[ $i ], @row[ $i ];
        }

        "%s  [%s]\n".printf: $tab, @row-str.join: ', ';
    }

    "$tab]".put;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $matrix-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str    @rows     = $matrix-str.split: / \; /, :skip-empty;
        my Matrix $matrix   = parse-matrix( @rows );
        my Bool   $x-matrix = is-x-matrix( $matrix );
        my Bool   $expected = $exp-str eq '1';

        is $x-matrix, $expected, $test-name;
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
        Example 1|1 0 0 2;  0 3 4 0;  0 5 6 0;  7 0 0 1|1
        Example 2|1 2 3  ;  4 5 6  ;  7 8 9            |0
        Example 3|1 0 2  ;  0 3 0  ;  4 0 5            |1
        END
}

################################################################################
