use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 251
=========================

TASK #2
-------
*Lucky Numbers*

Submitted by: Mohammad S Anwar

You are given a m x n matrix of distinct numbers.

Write a script to return the lucky number, if there is one, or -1 if not.

  A lucky number is an element of the matrix such that it is
  the minimum element in its row and maximum in its column.

Example 1

  Input: $matrix = [ [ 3,  7,  8],
                     [ 9, 11, 13],
                     [15, 16, 17] ];
  Output: 15

  15 is the only lucky number since it is the minimum in its row
  and the maximum in its column.

Example 2

  Input: $matrix = [ [ 1, 10,  4,  2],
                     [ 9,  3,  8,  7],
                     [15, 16, 17, 12] ];
  Output: 12

Example 3

  Input: $matrix = [ [7, 8],
                     [1, 2] ];
  Output: 7

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
Since -1 is returned on failure, elements of the input matrix are limited to
non-negative numbers. For convenience, they are in addition limited to integers.

Algorithm
---------
This is a simple search for a lucky number: if one is found, it is immediately
returned, otherwise after the search has completed -1 is returned.

In fact, there can only ever be one lucky number for a given matrix. Proof (by
contradiction):

1. Let element x = matrix(i, j) be a lucky number. Can there be another lucky
   number in the same matrix?

2. Assume there is a lucky number y = matrix(k, l) with k ≠ i and l ≠ j.

3. Let w = matrix(i, l). Since x is the smallest element in row i, w > x.
   And since y is the largest element in column l, y > w. So, y > w > x, and by
   transitivity, y > x (a).

4. Let z = matrix(k, j). Since x is the largest element in column j, z < x.
   And since y is the smallest element in row k, y < z. So, y < z < x, and by
   transitivity, y < x (b).

5. Relations (a) and (b) are mutually contradictory, therefore the assumption
   made in step 2 must be false. QED.

Note
----
This solution incorporates or adapts code used in the solution of Task 2 for
Challenge 248.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 251, Task #2: Lucky Numbers (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty matrix of distinct unsigned integers
    #  e.g., "3 7 8" "9 11 13" "15 16 17"
    #  Note: the input matrix must be rectangular

    *@matrix where { .elems > 0 && .all ~~ Str:D }
)
#===============================================================================
{
    my Array[Array[UInt]] $matrix = parse-matrix( @matrix );

    print-matrix( 'Input:  $matrix = ', $matrix );

    "Output: %d\n".printf: find-lucky-number( $matrix );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-lucky-number( List:D[List:D[UInt:D]] $matrix --> Int:D )
#-------------------------------------------------------------------------------
{
    for @$matrix -> Array[UInt] $row
    {
        my UInt $row-min = $row.min;                       # Row minimum

        for 0 .. $row.end -> UInt $col
        {
            if $row[ $col ] == $row-min
            {
                my UInt $col-max = 0;

                for 0 .. $matrix.end -> UInt $row          # Find column maximum
                {
                    my UInt $elem = $matrix[ $row; $col ];

                    $col-max = $elem if $elem > $col-max;
                }

                return $row-min if $row-min == $col-max;
            }
        }
    }

    return -1;
}

#-------------------------------------------------------------------------------
sub parse-matrix
(
    List:D[Str:D] $matrix-strs where { .elems > 0 }
--> List:D[List:D[UInt:D]]
)
#-------------------------------------------------------------------------------
{
    my Array[UInt] @matrix;
    my UInt        %dict{UInt};
    my UInt        $num-cols;

    for @$matrix-strs -> Str $row-str
    {
        my UInt @row = fill-row( $row-str, %dict );

        @matrix.push: @row;

        if $num-cols.defined
        {
            @row.elems == $num-cols
                or error( 'The matrix is not rectangular' );
        }
        else
        {
            ($num-cols = @row.elems) > 0
                or error( 'The first row is empty' );
        }
    }

    return @matrix;
}

#-------------------------------------------------------------------------------
sub fill-row( Str:D $row-str, Hash:D[UInt:D, UInt:D] $dict --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @row;

    for $row-str.split( / \s+ /, :skip-empty ) -> Str $elem-str
    {
        +$elem-str ~~ UInt:D
            or error( qq["$elem-str" is not a valid unsigned integer] );

        my UInt $elem = +$elem-str;         # Normalize

        ++$dict{ $elem } == 1
            or error( qq[Element "$elem" is repeated] );

        @row.push: $elem;
    }

    return @row;
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

    "$prefix\[ ".print;

    for 0 .. $matrix.end -> UInt $i
    {
        my Array[UInt] $row = $matrix[ $i ];
        my Str         @row-str;

        for 0 .. $row.end -> UInt $j
        {
            @row-str.push: '%*d'.sprintf: @width[ $j ], $row[ $j ];
        }

        "%s\[%s]".printf: $i == 0 ?? '' !! $tab ~ '  ', @row-str.join: ', ';

        put() unless $i == $matrix.end;
    }

    ' ]'.put;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $expected) = $line.split: / \| /;

        for     $test-name, $matrix-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Array[Array[UInt]] $matrix =
                parse-matrix( $matrix-str.split( / \; /, :skip-empty ).list );

        my Int $lucky-num = find-lucky-number( $matrix );

        is $lucky-num, $expected.Int, $test-name;
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
        Example 1|   3 7 8;   9 11 13;    15 16 17|15
        Example 2|1 10 4 2; 9 3  8  7; 15 16 17 12|12
        Example 3|     7 8;      1  2;            | 7
        Singleton|       4;                       | 4
        None     |     1 3;      4  2;            |-1
        END
}

################################################################################
