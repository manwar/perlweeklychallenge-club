use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 298
=========================

TASK #1
-------
*Maximal Square*

Submitted by: Mohammad Sajid Anwar

You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return its
area.

Example 1

  Input: @matrix = ([1, 0, 1, 0, 0],
                    [1, 0, 1, 1, 1],
                    [1, 1, 1, 1, 1],
                    [1, 0, 0, 1, 0])
  Output: 4

  Two maximal square found with same size marked as 'x':

  [1, 0, 1, 0, 0]
  [1, 0, x, x, 1]
  [1, 1, x, x, 1]
  [1, 0, 0, 1, 0]

  [1, 0, 1, 0, 0]
  [1, 0, 1, x, x]
  [1, 1, 1, x, x]
  [1, 0, 0, 1, 0]

Example 2

  Input: @matrix = ([0, 1],
                    [1, 0])
  Output: 1

  Two maximal square found with same size marked as 'x':

  [0, x]
  [1, 0]

  [0, 1]
  [x, 0]

Example 3

  Input: @matrix = ([0])
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
2. A non-empty list of same-length, non-empty, binary strings is entered on the
   command-line.

=end comment
#===============================================================================

use Test;

subset BitStr of Str where { .chars > 0 && / ^ <[ 0 1 ]>+ $ / };
subset Pos    of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 298, Task #1: Maximal Square (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of same-length binary strings, e.g., 1001 1111 0010

    *@matrix where { .elems > 0 && .all ~~ BitStr:D &&
                     .all.chars == @matrix[ 0 ].chars }
)
#===============================================================================
{
    my UInt $e = @matrix.end;

     "Input:  \@matrix = ([%s]".printf: format-row( @matrix[ 0  ] );
    "\n                   [%s]".printf: format-row( @matrix[ $_ ] ) for 1 .. $e;
    ')'.put;

    my UInt  $max-square = find-max-square( @matrix );

    "Output: $max-square".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-square( List:D[BitStr:D] $matrix --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $rows = $matrix.elems;
    my UInt $cols = $matrix[ 0 ].chars;

    for (1 .. ($rows, $cols).min).reverse -> Pos $side
    {
        for 0 .. $rows - $side -> UInt $row0
        {
            for 0 .. $cols - $side -> UInt $col0
            {
                if is-square( $matrix, $row0, $col0, $side )
                {
                    return $side * $side;
                }
            }
        }
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub is-square
(
    List:D[BitStr:D] $matrix,
    UInt:D           $row0,
    UInt:D           $col0,
    Pos:D            $side
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    for $row0 .. $row0 + $side - 1 -> UInt $row
    {
        return False if $matrix[ $row ].substr( $col0, $side ) ~~ / 0 /;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub format-row( BitStr:D $row --> Str:D )
#-------------------------------------------------------------------------------
{
    return $row.split( '', :skip-empty ).join: ', ';
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

        my BitStr @matrix     = $matrix-str.split: / \s+ /, :skip-empty;
        my UInt   $max-square = find-max-square( @matrix );

        is $max-square, $expected.Int, $test-name;
    }

    done-testing;
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
        Example 1|10100 10111 11111 10010                | 4
        Example 2|01 10                                  | 1
        Example 3|0                                      | 0
        4 x 4    |01111 11111 11111 01111 11110          |16
        Sieve    |01010 10101 01010 10101 01010          | 1
        Island   |0000000 0000110 0000110 0000000 0000000| 4
        END
}

################################################################################
