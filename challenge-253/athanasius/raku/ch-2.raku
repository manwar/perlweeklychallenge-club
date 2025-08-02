use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 253
=========================

TASK #2
-------
*Weakest Row*

Submitted by: Mohammad S Anwar

You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear
before 0.

A row i is weaker than a row j if one of the following is true:

  a) The number of 1s in row i is less than the number of 1s in row j.
  b) Both rows have the same number of 1 and i < j.

Write a script to return the order of rows from weakest to strongest.

Example 1

  Input: $matrix = [
                     [1, 1, 0, 0, 0],
                     [1, 1, 1, 1, 0],
                     [1, 0, 0, 0, 0],
                     [1, 1, 0, 0, 0],
                     [1, 1, 1, 1, 1]
                   ]
  Output: (2, 0, 3, 1, 4)

  The number of 1s in each row is:
  - Row 0: 2
  - Row 1: 4
  - Row 2: 1
  - Row 3: 2
  - Row 4: 5

Example 2

  Input: $matrix = [
                     [1, 0, 0, 0],
                     [1, 1, 1, 1],
                     [1, 0, 0, 0],
                     [1, 0, 0, 0]
                   ]
  Output: (0, 2, 3, 1)

  The number of 1s in each row is:
  - Row 0: 1
  - Row 1: 4
  - Row 2: 1
  - Row 3: 1

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

=end comment
#===============================================================================

use Test;

subset Bin    of Int where 0 | 1;
subset BinStr of Str where / ^ 1 <[ 0 1 ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 253, Task #2: Weakest Row (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Non-empty binary matrix in which each row begins with 1
    #  e.g., 11000 11110 10000 11000 11111

    *@matrix where { .elems > 0 && .all ~~ BinStr:D }
)
#===============================================================================
{
    my Array[Array[Bin]] $matrix = parse-matrix( @matrix );

    print-matrix( 'Input:  $matrix = ', $matrix );

    my UInt @ranked = rank-rows( $matrix );

    "Output: (%s)\n".printf: @ranked.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub rank-rows( List:D[List:D[Bin:D]] $matrix --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @ranked = (0 .. $matrix.end).sort:
                {
                    ([+] $matrix[ $^a ].list) <=> ([+] $matrix[ $^b ].list)
                                              ||
                                          $^a <=> $^b
                };

    return  @ranked;
}

#-------------------------------------------------------------------------------
sub parse-matrix
(
    List:D[BinStr:D] $matrix-strs where { .elems > 0 }
--> List:D[List:D[Bin:D]]
)
#-------------------------------------------------------------------------------
{
    my Array[Bin] @matrix;
    my UInt       $num-cols;
    
    for @$matrix-strs -> Str $row
    {
        my Bin @row = $row.split( '', :skip-empty ).map: { .Int };

        @row[ 0 ] == 1 or error( 'Row does not begin with 1' );

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
sub print-matrix( Str:D $prefix, List:D[List:D[Bin:D]] $matrix )
#-------------------------------------------------------------------------------
{
    my Str $tab = ' ' x $prefix.chars;

    "$prefix\[ ".print;

    for 0 .. $matrix.end -> UInt $i
    {
        my Array[Bin] $row = $matrix[ $i ];

        '%s[%s]'.printf: $i == 0 ?? '' !! "$tab  ", $row.join: ', ';

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
        my Str ($test-name, $matrix-strs, $expected-str) = $line.split: / \| /;

        for     $test-name, $matrix-strs, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my BinStr     @rows     = $matrix-strs\.split: / \s+ /;
        my Array[Bin] @matrix   = parse-matrix( @rows );
        my UInt       @ranked   = rank-rows( @matrix );
        my UInt       @expected = $expected-str.split( / \s+ / ). map: { .Int };

        is-deeply @ranked, @expected, $test-name;
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
        Example 1|11000 11110 10000 11000 11111|2 0 3 1 4
        Example 2|1000  1111  1000  1000       |0 2 3 1
        Singleton|1                            |0
        END
}

################################################################################
