use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 271
=========================

TASK #1
-------
*Maximum Ones*

Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of more
than one rows then return smallest row number.

Example 1

  Input: $matrix = [ [0, 1],
                     [1, 0],
                   ]
  Output: 1

  Row 1 and Row 2 have the same number of ones, so return row 1.

Example 2

  Input: $matrix = [ [0, 0, 0],
                     [1, 0, 1],
                   ]
  Output: 2

  Row 2 has the maximum ones, so return row 2.

Example 3

  Input: $matrix = [ [0, 0],
                     [1, 1],
                     [0, 0],
                   ]
  Output: 2

  Row 2 have the maximum ones, so return row 2.

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
2. The matrix is entered on the command-line as a series of non-empty, same-
   length bit-strings, one for each matrix row.

Reference
---------
Code for handling binary matrices adapted from the Perl solution to Week 270,
Task #1, "Special Positions".

=end comment
#===============================================================================

use Test;

subset Bit    of Int where 0 | 1;
subset BitStr of Str where / ^ <[01]>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 271, Task #1: Maximum Ones (Raku)\n".put;
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

    "Input:  \$matrix = [%s]\n"\  .printf: @binary[ 0    ].join: ' ';

    for 1 .. @binary.end -> UInt $row
    {
        "                  [%s]\n".printf: @binary[ $row ].join: ' ';
    }

    my UInt $row = find-max-row( @binary );

    "Output: $row".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-row( List:D[List:D[Bit:D]] $matrix --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-count = 0;
    my UInt $max-row   = 0;

    for 0 .. $matrix.end -> UInt $row
    {
        my UInt $count = [+] $matrix[ $row ].list;

        if $count > $max-count
        {
            $max-count = $count;
            $max-row   = $row;
        }
    }

    return $max-row + 1;                    # Change from 0- to 1-based indexing
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[BitStr:D] $rows --> List:D[List:D[Bit:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Bit] @matrix;
    my UInt       $n = $rows[ 0 ].chars;

    for @$rows -> BitStr $row-str
    {
        $row-str.chars == $n or error( 'The input matrix is not rectangular' );

        my Bit @row = $row-str.split( '', :skip-empty ).map: { .Int };

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

        my BitStr     @rows   = $matrix-str.split: / \s+ /, :skip-empty;
        my Array[Bit] @matrix = parse-matrix( @rows );
        my UInt       $row    = find-max-row( @matrix );

        is $row, $expected-str.Int, $test-name;
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
        Example 1|01    10                     |1
        Example 2|000   101                    |2
        Example 3|00    11    00               |2
        Singleton|0                            |1
        1st of 2 |00000 11011 00100 10111 00000|2
        Last     |0000  0100  1010  1011  1111 |5
        END
}

################################################################################
