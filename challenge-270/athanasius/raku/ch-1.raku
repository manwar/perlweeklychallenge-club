use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 270
=========================

TASK #1
-------
*Special Positions*

Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the number of special positions in the given binary
matrix.

    A position (i, j) is called special if $matrix[i][j] == 1 and all other
    elements in the row i and column j are 0.

Example 1

  Input: $matrix = [ [1, 0, 0],
                     [0, 0, 1],
                     [1, 0, 0],
                   ]
  Output: 1

  There is only special position (1, 2) as $matrix[1][2] == 1
  and all other elements in row 1 and column 2 are 0.

Example 2

  Input: $matrix = [ [1, 0, 0],
                     [0, 1, 0],
                     [0, 0, 1],
                   ]
  Output: 3

  Special positions are (0,0), (1, 1) and (2,2).

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
-----------
The input matrix is not empty (i.e., m > 0 and n > 0).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The matrix is entered on the command-line as a series of same-length bit-
   strings, one for each matrix row.
3. If the constant $VERBOSE is set to a true value, the required output (number
   of special positions) is followed by a list of the special positions found.

Reference
---------
Code for handling binary matrices adapted from the Raku solution to Week 242,
Task #2, "Flip Matrix".

=end comment
#===============================================================================

use Test;

subset Bit    of Int where 0 | 1;
subset BitStr of Str where / ^ <[01]>+ $ /;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 270, Task #1: Special Positions (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty m x n binary matrix, e.g., 1100 0110 0010

    *@matrix where { .elems > 0 && .all ~~ BitStr:D }
)
#===============================================================================
{
    my Array[Bit] @binary = parse-matrix( @matrix );

    "Input: \$matrix = [%s]\n"\  .printf: @binary[ 0    ].join: ' ';

    for 1 .. @binary.end -> UInt $row
    {
        "                 [%s]\n".printf: @binary[ $row ].join: ' ';
    }

    my Array[UInt] @positions = find-special-positions( @binary );
    my UInt        $count     = @positions.elems;

    "Output: $count".put;

    if VERBOSE
    {
        my Str $indices = $count == 0 ?? 'none' !!
                          @positions.map( { '(%s)'.sprintf: .join: ', ' } )\
                                                            .join: ', ';

        "\nSpecial position%s: %s\n".printf: $count == 1 ?? '' !! 's', $indices;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-special-positions
(
    List:D[List:D[Bit:D]] $matrix
--> List:D[List:D[UInt:D]]
)
#-------------------------------------------------------------------------------
{
    my Array[UInt] @positions = Array[Array[UInt]].new;
    my UInt        $cols-end  = $matrix[ 0 ].end;

    L-ROWS:
    for 0 .. $matrix.end -> UInt $row
    {
        for 0 .. $cols-end -> UInt $col
        {
            next unless $matrix[ $row; $col ] == 1;

            for $col + 1 .. $cols-end -> UInt $c
            {
                next L-ROWS unless $matrix[ $row; $c ] == 0;
            }

            for 0 .. $matrix.end -> UInt $r
            {
                next if $r == $row;

                next L-ROWS unless $matrix[ $r; $col ] == 0;
            }

            @positions.push: Array[UInt].new: $row, $col;
            next L-ROWS;
        }
    }

    return @positions;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[BitStr:D] $rows --> List:D[List:D[Bit:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Bit] @matrix;
    my Bit        @row = $rows[ 0 ].split( '', :skip-empty ).map: { .Int };
    my UInt       $n   = @row.elems;

    @matrix.push: @row;

    for 1 .. $rows.end -> UInt $col
    {
        my BitStr $row-str = $rows[ $col ];
        my Bit    @row = $row-str\ .split( '', :skip-empty ).map: { .Int };

        @row.elems == $n or error( 'The input matrix is not rectangular' );

        @matrix.push: @row;
    }

    return @matrix;
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

        my BitStr      @rows      = $matrix-str.split: / \s+ /, :skip-empty;
        my Array[Bit]  @matrix    = parse-matrix( @rows );
        my Array[UInt] @positions = find-special-positions( @matrix );
        my Array[UInt] @expected;

        for $expected-str.split: / \s* \; \s* /, :skip-empty
        {
            @expected.push: Array[UInt].new: .split( / \s+ / ).map: { .Int };
        }

        is-deeply @positions, @expected, $test-name;
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
        Example 1  |100   001   100        |1 2
        Example 2  |100   010   001        |0 0; 1 1; 2 2
        4x5        |10100 01000 00100 00010|1 1; 3 3
        None       |101   010   101   010  |
        Singleton 0|0                      |
        Singleton 1|1                      |0 0
        Same column|00100 00000 00100 00001|3 4
        Same row   |0000  1001  0010  0000 |2 2
        END
}

################################################################################
