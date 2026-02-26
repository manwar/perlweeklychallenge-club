use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 361
=========================

TASK #2
-------
*Find Celebrity*

Submitted by: Mohammad Sajid Anwar

You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

    A celebrity is someone, everyone knows and knows nobody.

Example 1

  Input: @party = (
              [0, 0, 0, 0, 1, 0],  # 0 knows 4
              [0, 0, 0, 0, 1, 0],  # 1 knows 4
              [0, 0, 0, 0, 1, 0],  # 2 knows 4
              [0, 0, 0, 0, 1, 0],  # 3 knows 4
              [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
              [0, 0, 0, 0, 1, 0],  # 5 knows 4
         );
  Output: 4

Example 2

  Input: @party = (
              [0, 1, 0, 0],  # 0 knows 1
              [0, 0, 1, 0],  # 1 knows 2
              [0, 0, 0, 1],  # 2 knows 3
              [1, 0, 0, 0]   # 3 knows 0
         );
  Output: -1

Example 3

  Input: @party = (
              [0, 0, 0, 0, 0],  # 0 knows NOBODY
              [1, 0, 0, 0, 0],  # 1 knows 0
              [1, 0, 0, 0, 0],  # 2 knows 0
              [1, 0, 0, 0, 0],  # 3 knows 0
              [1, 0, 0, 0, 0]   # 4 knows 0
         );
  Output: 0

Example 4

  Input: @party = (
              [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
              [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
              [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
              [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
              [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
              [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
         );
  Output: 3

Example 5

  Input: @party = (
              [0, 1, 1, 0],  # 0 knows 1 and 2
              [1, 0, 1, 0],  # 1 knows 0 and 2
              [0, 0, 0, 0],  # 2 knows NOBODY
              [0, 0, 0, 0]   # 3 knows NOBODY
         );
  Output: -1

Example 6

  Input: @party = (
              [0, 0, 1, 1],  # 0 knows 2 and 3
              [1, 0, 0, 0],  # 1 knows 0
              [1, 1, 0, 1],  # 2 knows 0, 1 and 3
              [1, 1, 0, 0]   # 3 knows 0 and 1
         );
  Output: -1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The matrix must in fact be m x m, i.e., square, as shown in all the Examples.
2. It is irrelevant whether or not a celebrity "knows himself."

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of bitstrings is entered on the command-line. The bitstrings
   represent the rows of a non-empty, square, binary matrix.

=end comment
#===============================================================================

use Test;

subset Bit    of Int where 0 | 1;
subset BitStr of Str where * ~~ / ^ <[ 0 1 ]>+ $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 361, Task #2: Find Celebrity (Raku)\n".put;
}

#===============================================================================
class Matrix
#===============================================================================
{
    has Array[Bit] @!rows;

    #---------------------------------------------------------------------------
    method find-celebrity( --> Int:D )
    #---------------------------------------------------------------------------
    {
        my Int $celebrity = -1;
        my Int @know-noone;

        for 0 .. @!rows.end -> UInt $row
        {
            my UInt $sum = 0;

            for 0 .. @!rows[$row].end -> UInt $col
            {
                next if $col == $row;

                $sum += @!rows[$row; $col];
            }

            @know-noone.push: $row if $sum == 0;
        }

        if @know-noone.elems == 1
        {
            my UInt $candidate = @know-noone[0];
            my Bool $known     = True;

            for 0 .. @!rows.end -> UInt $row
            {
                next if $row == $candidate;

                if @!rows[$row, $candidate] == 0
                {
                    $known = False;
                    last;
                }
            }

            $celebrity = $candidate if $known;
        }

        return $celebrity;
    }

    #---------------------------------------------------------------------------
    method format( UInt:D $indent --> Str:D )
    #---------------------------------------------------------------------------
    {
        my Str $tab     = ' ' x $indent;
        my Str $display = "$tab\(\n";

        for @!rows -> Array[Bit] $row
        {
            $display ~= "$tab    \[" ~ $row.join( ', ' ) ~ "]\n";
        }

        return $display ~ "$tab)";
    }

    #---------------------------------------------------------------------------
    submethod BUILD
    (
        :@!rows,
        List:D[BitStr:D] :$bitstrs where { .elems > 0 }
    )
    #---------------------------------------------------------------------------
    {
        my UInt $width = $bitstrs[0].chars;

        $bitstrs.elems == $width or error( 'Matrix not square' );

        for @$bitstrs -> BitStr $bitstr
        {
            $bitstr.chars == $width
                or error( qq[Matrix not square at "$bitstr"] );

            @!rows.push: Array[Bit].new:
                         $bitstr.split( '', :skip-empty ).map: { .Int };
        }
    }
}

#===============================================================================
multi sub MAIN
(
    #| A list of bitstrings: the rows of a square binary matrix

    *@party where { .elems > 0 && .all ~~ BitStr:D }
)
#===============================================================================
{
    my Matrix $matrix = Matrix.new( bitstrs => @party );

    "Input:  \@party =\n%s;\n".printf: $matrix.format( 8 );

    my Int $celebrity = $matrix.find-celebrity;

    "Output: $celebrity".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $party-str, $expected) = $line.split: / \| /;

        for     $test-name, $party-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str    @party-rows = $party-str.split: / \s+ /, :skip-empty;
        my Matrix $matrix     = Matrix.new( bitstrs => @party-rows );
        my Int    $celebrity  = $matrix.find-celebrity;

        is $celebrity, $expected.Int, $test-name;
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
        Example 1|000010 000010 000010 000010 000000 000010| 4
        Example 2|0100   0010   0001   1000                |-1
        Example 3|00000  10000  10000  10000  10000        | 0
        Example 4|010101 101100 000110 000000 010100 101100| 3
        Example 5|0110   1010   0000   0000                |-1
        Example 6|0011   1000   1101   1100                |-1
        END
}

################################################################################
