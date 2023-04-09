use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 211
=========================

TASK #1
-------
*Toeplitz Matrix*

Submitted by: Mohammad S Anwar

You are given a matrix m x n.

Write a script to find out if the given matrix is Toeplitz Matrix.

    A matrix is Toeplitz if every diagonal from top-left to bottom-right has the
    same elements.

Example 1

  Input: @matrix = [ [4, 3, 2, 1],
                     [5, 4, 3, 2],
                     [6, 5, 4, 3],
                   ]
  Output: true

Example 2

  Input: @matrix = [ [1, 2, 3],
                     [3, 2, 1],
                   ]
  Output: false

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
    "\nChallenge 211, Task #1: Toeplitz Matrix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $matrix                #= String representing a matrix
)
#===============================================================================
{
    my @matrix = parse-matrix-string( $matrix );

    "Input:  \@matrix = %s\n".printf: format-matrix( @matrix );

    "Output: %s\n".printf: is-toeplitz-matrix( @matrix ) ?? 'True' !! 'False';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-toeplitz-matrix( List:D[List:D[Str:D]] $matrix --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $rows = $matrix.elems;
    my UInt $cols = $matrix[ 0 ].elems;

    for 0 .. $rows - 2 -> UInt $row
    {
        for 0 .. $cols - 2 -> UInt $col
        {
            return False unless $matrix[ $row;     $col     ] eq
                                $matrix[ $row + 1; $col + 1 ];
        }
    }

    return True;
}

#-------------------------------------------------------------------------------
sub parse-matrix-string( Str:D $matrix --> List:D[List:D[Str:D]] )
#-------------------------------------------------------------------------------
{
    $matrix ~~ / ^ \s* \[ \s* (.+) \] \s* $ /
        or error( 'Malformed matrix string (1)' );

    my Str $string = $0.Str;

    $string ~~ / ^ \[ .+ \] \s* $ /
        or error( 'Malformed matrix string (2)' );

    my Array[Str] @matrix;
    my Match      @matches = $string ~~ m:g/ \,? \s* \[ \s* .+? \] /;

    for @matches -> Match $match
    {
        $match.Str ~~ / ^ \,? \s* \[ (.+) \] $ /
            or error( 'Malformed matrix string (3)' );

        my Str @elems = $0.split: / \, \s* /;

        s/ ^ \s+ //, s/ \s+ $ // for @elems;

        @matrix.push: Array[Str].new: @elems;
    }

    @matrix.elems > 0 or error( 'Empty matrix' );

    my UInt $cols = @matrix[ 0 ].elems;

    for 1 .. @matrix.end -> UInt $row
    {
        @matrix[ $row ].elems == $cols or error( 'Ragged array' );
    }

    return @matrix;
}

#-------------------------------------------------------------------------------
sub format-matrix( List:D[List:D[Str:D]] $matrix --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @rows;

    for @$matrix -> List $row
    {
        @rows.push: '[' ~ $row.join( ', ' ) ~ ']';
    }

    return '[ ' ~ @rows.join( ', ' ) ~ ' ]';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $input, $expected) = $line.split: / \| /;

        $test-name ~~ s/ \s+ $ //;              # Trim whitespace
        $input     ~~ s/ \s+ $ //;

        my Array[Array[Str]] $matrix = parse-matrix-string( $input );

        my Str $got = is-toeplitz-matrix( $matrix ) ?? 'True' !! 'False';

        is $got, $expected, $test-name;
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
        Example 1     |[[4,3,2,1],[5,4,3,2],[6,5,4,3]]      |True
        Example 2     |[[1,2,3],[3,2,1]]                    |False
        Single element|[[42]]                               |True
        Single row    |[[17,-3,12,9,5,0,7]]                 |True
        Single column |[[apple][banana][guava][pear]]       |True
        Alternating   |[[0,1,0,1,0],[1,0,1,0,1],[0,1,0,1,0]]|True
        Deceptive 1   |[[0,1,0,1,0],[1,0,1,0,1],[0,1,O,1,0]]|False
        Deceptive 2   |[[O,1,0,1,0],[1,O,1,0,1],[0,1,O,1,0]]|True
        END
}

################################################################################
