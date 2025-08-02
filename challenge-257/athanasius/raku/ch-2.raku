use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 257
=========================

TASK #2
-------
*Reduced Row Echelon*

Submitted by: Ali Moradi

Given a matrix M, check whether the matrix is in reduced row echelon form.

A matrix must have the following properties to be in reduced row echelon form:

  1. If a row does not consist entirely of zeros, then the first
     nonzero number in the row is a 1. We call this the leading 1.
  2. If there are any rows that consist entirely of zeros, then
     they are grouped together at the bottom of the matrix.
  3. In any two successive rows that do not consist entirely of zeros,
     the leading 1 in the lower row occurs farther to the right than
     the leading 1 in the higher row.
  4. Each column that contains a leading 1 has zeros everywhere else
     in that column.

For example:

  [
     [1,0,0,1],
     [0,1,0,2],
     [0,0,1,3]
  ]

The above matrix is in reduced row echelon form since the first nonzero number
in each row is a 1, leading 1s in each successive row are farther to the right,
and above and below each leading 1 there are only zeros.

For more information check out this wikipedia 
[https://en.wikipedia.org/wiki/Row_echelon_form|article].

Example 1

    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 2

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1

Example 3

    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1

Example 4

    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0

Example 5

    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0

Example 6

    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input matrix M is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        [ 1 1 0 ]
        [ 0 1 0 ]
        [ 0 0 0 ]

    is entered as: >raku ch-2.raku "1 1 0" "0 1 0" "0 0 1"

Assumptions
-----------
1. The input matrix M is an integer matrix.
2. M is not an empty matrix.

Note
----
Matrix-handling code is adapted from the solution to Task 2 for Week 248.

=end comment
#===============================================================================

use Test;

enum   RowType < AllZeros LeadingOne Other >;
subset Matrix of Array where * ~~ Array[Array[Int]];

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 257, Task #2: Reduced Row Echelon (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@M where { .all ~~ Str:D && .elems > 0 }      #= A non-empty integer matrix
)
#===============================================================================
{
    my Matrix $matrix = parse-matrix( @M );

    print-matrix( 'Input:  $M = ', $matrix );

    my Bool $is-rre = is-reduced-row-echelon( $matrix );

    "Output: %d\n".printf: $is-rre ?? 1 !! 0;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-reduced-row-echelon( Matrix:D $matrix --> Bool:D )
#-------------------------------------------------------------------------------
{
    # Test matrix properties 1 and 2:
    # 1. If a row does not consist entirely of zeros, then the first nonzero
    #    number in the row is a 1. We call this the leading 1.
    # 2. If there are any rows that consist entirely of zeros, then they are
    #    grouped together at the bottom of the matrix.

    my RowType @row-types = classify-rows( $matrix );
    my Bool    $all-zeros = False;

    for @row-types -> RowType $type
    {
        given $type
        {
            when AllZeros   { $all-zeros = True;          }
            when LeadingOne { return False if $all-zeros; }      # Requirement 2
            when Other      { return False;               }      # Requirement 1
        }
    }

    # Test matrix properties 3 and 4:
    # 3. In any two successive rows that do not consist entirely of zeros, the
    #    leading 1 in the lower row occurs farther to the right than the leading
    #    1 in the higher row.
    # 4. Each column that contains a leading 1 has zeros everywhere else in that
    #    column.

    return check-leading-ones( $matrix, @row-types );
}

#-------------------------------------------------------------------------------
sub classify-rows( Matrix:D $matrix --> List:D[RowType:D] )
#-------------------------------------------------------------------------------
{
    my RowType @row-types;
    my UInt    $width = $matrix[ 0 ].elems;

    L-OUTER:
    for 0 .. $matrix.end -> UInt $r
    {
        my Array[Int] $row = $matrix[ $r ];

        for 0 .. $width - 1 -> UInt $c
        {
            my Int $element = $row[ $c ];

            if    $element == 1
            {
                @row-types.push: LeadingOne;
                next L-OUTER;
            }
            elsif $element != 0
            {
                @row-types.push: Other;
                next L-OUTER;
            }
        }

        @row-types.push: AllZeros;
    }

    return @row-types;
}

#-------------------------------------------------------------------------------
sub check-leading-ones( Matrix:D $matrix, List:D[RowType:D] $row-t --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $width    = $matrix[ 0 ].elems;
    my Int  $last-one = -1;

    for 0 .. $matrix.end -> UInt $r
    {
        last if $row-t[ $r ] == AllZeros;

        my Array[Int] $row = $matrix[ $r ];

        for 0 .. $width - 1 -> UInt $c
        {
            my Int $element = $row[ $c ];

            if $element == 1
            {
                return False unless $c > $last-one;         # Test Requirement 3

                $last-one = $c;

                for 0 .. $matrix.end -> UInt $rr            # Test Requirement 4
                {
                    return False unless $rr == $r || $matrix[ $rr; $c ] == 0;
                }

                last;
            }
        }
    }

    return True;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[Str:D] $M --> Matrix:D )
#-------------------------------------------------------------------------------
{
    my Matrix $matrix = Array[Array[Int]].new;
    my UInt   $num-cols;

    for @$M -> Str $row-str
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

        $matrix.push: @row;

        if $num-cols.defined
        {
            @row.elems == $num-cols
                or error( 'The input matrix is not rectangular' );
        }
        else
        {
            ($num-cols = @row.elems) > 0 or error( 'Empty row' );
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

        my Str    @M        = $matrix-str.split: / \; /, :skip-empty;
        my Matrix $matrix   = parse-matrix( @M );
        my Bool   $is-rre   = is-reduced-row-echelon( $matrix );
        my Bool   $expected = $exp-str eq '1';

        is $is-rre, $expected, $test-name;
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
        Example 0|1 0  0 1  ;   0 1 0 2   ;   0 0 1  3               |1
        Example 1|1 1  0    ;   0 1 0     ;   0 0 0                  |0
        Example 2|0 1 -2 0 1;   0 0 0 1  3;   0 0 0  0 0;   0 0 0 0 0|1
        Example 3|1 0  0 4  ;   0 1 0 7   ;   0 0 1 -1               |1
        Example 4|0 1 -2 0 1;   0 0 0 0  0;   0 0 0  1 3;   0 0 0 0 0|0
        Example 5|0 1  0    ;   1 0 0     ;   0 0 0                  |0
        Example 6|4 0  0 0  ;   0 1 0 7   ;   0 0 1 -1               |0
        END
}

################################################################################
