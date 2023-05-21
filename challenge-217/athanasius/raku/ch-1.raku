use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 217
=========================

TASK #1
-------
*Sorted Matrix*

Submitted by: Mohammad S Anwar

You are given a n x n matrix where n >= 2.

Write a script to find 3rd smallest element in the sorted matrix.

Example 1

  Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
  Output: 1

  The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
  The 3rd smallest of the sorted list is 1.

Example 2

  Input: @matrix = ([2, 1], [4, 5])
  Output: 4

  The sorted list of the given matrix: 1, 2, 4, 5.
  The 3rd smallest of the sorted list is 4.

Example 3

  Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
  Output: 0

  The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
  The 3rd smallest of the sorted list is 0.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True (the default), the output is followed by an explan-
   ation of the result

Assumption
----------
Matrix elements are integers.

=end comment
#===============================================================================

use Test;

subset Result of List where (Int, Array[Int]);

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 217, Task #1: Sorted Matrix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| String representation of an n x n integer matrix where n >= 2

    Str:D $matrix
)
#===============================================================================
{
    my Array[Int] @matrix = parse-matrix-string( $matrix );

    "Input:  \@matrix = %s\n".printf: format-matrix( @matrix );

    my Result $result = find-third-smallest( @matrix );

    "Output: %d\n".printf: $result[ 0 ];

    if VERBOSE
    {
        my Int @elements = $result[ 1 ];

        "\nThe sorted list of the given matrix: %s\n".printf:
            @elements.join: ', ';

        my UInt $padding = @elements[ 0 ].chars + @elements[ 1 ].chars + 4;

        "The third-smallest element:          %s%s\n".printf:
            ' ' x $padding, '^' x $result[ 0 ].chars;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-third-smallest( List:D[List:D[Int:D]] $matrix --> Result:D )
#-------------------------------------------------------------------------------
{
    my Int @elements;

    @elements.push: |$_ for @$matrix;

    @elements.= sort;

    @elements.elems >= 3 or error( 'Matrix too small' );

    return @elements[ 2 ], @elements;
}

#===============================================================================
grammar Matrix
#===============================================================================
{
    token TOP  { ^ \s* '(' \s* [ <row>  <sep> ]+ <row>  \s* ')' \s* $ }
    token row  {       '[' \s* [ <elem> <sep> ]+ <elem> \s* ']'       }
    token elem { <[-+]>? <[0..9]>+ }
    token sep  { \, \s*            }
}

#-------------------------------------------------------------------------------
sub parse-matrix-string( Str:D $matrix --> List:D[List:D[Int:D]] )
#-------------------------------------------------------------------------------
{
    my Matrix $parsed = Matrix.parse( $matrix )
        or error( 'Invalid input string' );

    my Array[Int] @matrix;
    my Str        @rows = $parsed< row >.map: { .Str };

    for @rows -> Str $row
    {
        $row ~~ / ^ \[ \s* (.+?) \s* \] $ /;

        @matrix.push: Array[Int].new: $0.Str.split( / \, \s* / ).map: { .Int };
    }

    validate-matrix( @matrix );

    return @matrix;
}

#-------------------------------------------------------------------------------
sub validate-matrix( List:D[List:D[Int:D]] $matrix )
#-------------------------------------------------------------------------------
{
    my UInt $rows = $matrix.elems;
    my UInt $n    = $matrix[ 0 ].elems;

    $rows >=  2 or error( 'Too few rows in matrix' );
    $rows == $n or error( 'Matrix is not square'   );

    for 1 .. $matrix.end -> UInt $i
    {
        my UInt $m = $matrix[ $i ].elems;
        my UInt $j = $i + 1;

        $m == $n or error( "In matrix row $j: expected $n elements, found $m" );
    }
}

#-------------------------------------------------------------------------------
sub format-matrix( List:D[List:D[Int:D]] $matrix --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $matrix-str = '(';
    my Str @row-strs;

    for @$matrix -> Int @elems
    {
        @row-strs.push: '[' ~ @elems.join( ', ' ) ~ ']';
    }

    $matrix-str ~= @row-strs.join( ', ' ) ~ ')';

    return $matrix-str;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $expected) = $line.split: / \| /;

        s/ \s+ $ // for $test-name, $matrix-str;               # Trim whitespace

        my Array[Int] @matrix = parse-matrix-string( $matrix-str );
        my Result     $result = find-third-smallest( @matrix );

        is $result[ 0 ], $expected.Int, $test-name;
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
        Example 1|([3,  1,  2], [5,  2,  4], [ 0, 1, 3])| 1
        Example 2|([2,  1],     [4,  5])                | 4
        Example 3|([1,  0,  3], [0,  0,  0], [ 1, 2, 1])| 0
        Negatives|([0, -1, -2], [0, -1, -3], [-3, 1, 2])|-2
        END
}

################################################################################
