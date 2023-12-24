use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 248
=========================

TASK #2
-------
*Submatrix Sum*

Submitted by: Jorg Sommrey

You are given a NxM matrix A of integers.

Write a script to construct a (N-1)x(M-1) matrix B having elements that are the
sum over the 2x2 submatrices of A,

  b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1

  Input: $a = [
                [1,  2,  3,  4],
                [5,  6,  7,  8],
                [9, 10, 11, 12]
              ]

  Output: $b = [
                 [14, 18, 22],
                 [30, 34, 38]
               ]

Example 2

  Input: $a = [
                [1, 0, 0, 0],
                [0, 1, 0, 0],
                [0, 0, 1, 0],
                [0, 0, 0, 1]
              ]

  Output: $b = [
                 [2, 1, 0],
                 [1, 2, 1],
                 [0, 1, 2]
               ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 248, Task #2: Submatrix Sum (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| An N x M matrix of integers (N, M >= 2)

    *@a where { .all ~~ Str:D && .elems >= 2 }
)
#===============================================================================
{
    my Array[Array[Int]] $matrix-a = parse-matrix( @a );

    print-matrix( 'Input:  $a = ', $matrix-a );

    my Array[Array[Int]] $matrix-b = submatrix-sum( $matrix-a );

    put();
    print-matrix( 'Output: $b = ', $matrix-b );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub submatrix-sum( List:D[List:D[Int:D]] $matrix-a --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @matrix-b;

    for 0 .. $matrix-a.end - 1 -> UInt $i
    {
        @matrix-b[ $i ] = Array[Int].new;

        for 0 .. $matrix-a[ 0 ].end - 1 -> UInt $k
        {
            # b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

            @matrix-b[ $i; $k ] = $matrix-a[ $i;     $k     ] +
                                  $matrix-a[ $i;     $k + 1 ] +
                                  $matrix-a[ $i + 1; $k     ] +
                                  $matrix-a[ $i + 1; $k + 1 ];
        }
    }

    return @matrix-b;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[Str:D] $a --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Int] @matrix;
    my UInt       $num-cols;

    for @$a -> Str $row-str
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

        @matrix.push: @row;

        if $num-cols.defined
        {
            @row.elems == $num-cols
                or error( 'The input matrix is not rectangular' );
        }
        else
        {
            ($num-cols = @row.elems) >= 2 or error( 'M is too small' );
        }
    }

    return @matrix;
}

#-------------------------------------------------------------------------------
sub print-matrix( Str:D $prefix, List:D[List:D[Int:D]] $matrix )
#-------------------------------------------------------------------------------
{
    my Str  $tab   = ' ' x $prefix.chars;
    my UInt @width = 1 xx $matrix[ 0 ].elems;

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
        my Str ($test-name, $matrix-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $matrix-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @a = $matrix-str\ .split: / \; /;
        my Str @b = $expected-str.split: / \; /;

        my Array[Array[Int]] $matrix-a = parse-matrix( @a );
        my Array[Array[Int]] $expected = parse-matrix( @b );
        my Array[Array[Int]] $matrix-b = submatrix-sum( $matrix-a );

        is-deeply $matrix-b, $expected, $test-name;
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
        Example 1|1 2 3 4; 5 6 7 8; 9 10 11 12|14 18 22; 30 34 38
        Example 2|1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1|2 1 0; 1 2 1; 0 1 2
        END
}

################################################################################
