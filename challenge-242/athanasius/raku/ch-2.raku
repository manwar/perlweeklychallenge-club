use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 242
=========================

TASK #2
-------
*Flip Matrix*

Submitted by: Mohammad S Anwar

You are given n x n binary matrix.

Write a script to flip the given matrix as below.

  1 1 0
  0 1 1
  0 0 1

  a) Reverse each row

  0 1 1
  1 1 0
  1 0 0

  b) Invert each member

  1 0 0
  0 0 1
  0 1 1

Example 1

  Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
  Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2

  Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
  Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

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

subset Bit    of Int where 0 | 1;
subset BitStr of Str where / ^ <[01]>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 242, Task #2: Flip Matrix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| An n x n binary matrix, for example: 110 011 001

    *@matrix where { .all ~~ BitStr:D }
)
#===============================================================================
{
    my Array[Bit] @binary  = parse-matrix( @matrix );

    "Input: \@matrix = (%s)\n".printf:
        @binary\.map( { '[' ~ @$_.join( ', ' ) ~ ']' } ).join: ', ';

    my Array[Bit] @flipped = flip-matrix( @binary );

    "Output:          (%s)\n".printf:
        @flipped.map( { '[' ~ @$_.join( ', ' ) ~ ']' } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub flip-matrix( List:D[List:D[Bit:D]] $matrix --> List:D[List:D[Bit:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Bit] @flipped = @$matrix;
    my UInt       $end     = @flipped.end;

    # a) Reverse each row

    for 0 .. $end -> UInt $i
    {
        @flipped[ $i ] = Array[Bit].new: @flipped[ $i ].reverse;
    }

    # b) Invert each member

    for 0 .. $end -> UInt $i
    {
        for 0 .. $end -> UInt $j
        {
            @flipped[ $i; $j ] = @flipped[ $i; $j ] == 0 ?? 1 !! 0;
        }
    }

    return @flipped;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[BitStr:D] $rows --> List:D[List:D[Bit:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Bit] @matrix;
    my UInt       $n = $rows.elems;

    for @$rows -> Str $row
    {
        $row.chars == $n or error( 'The input matrix is not square' );

        my Bit @new-row = $row.split( '', :skip-empty ).map: { .Int };

        @matrix.push: @new-row;
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
        my Str ($test-name, $matrix-str, $expect-str) = $line.split: / \| /;

        for     $test-name, $matrix-str, $expect-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Array[Bit] @bnry = parse-matrix( $matrix-str.split( / \s+ / ).list );
        my Array[Bit] @flip = flip-matrix\( @bnry );
        my Array[Bit] @expt = parse-matrix( $expect-str.split( / \s+ / ).list );

        is-deeply @flip, @expt, $test-name;
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
        Example 0|110  011  001      |100  001  011
        Example 1|110  101  000      |100  010  111
        Example 2|1100 1001 0111 1010|1100 0110 0001 1010
        END
}

################################################################################
