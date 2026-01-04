use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 354
=========================

TASK #2
-------
*Shift Grid*

Submitted by: Mohammad Sajid Anwar

You are given m x n matrix and an integer, $k > 0.

Write a script to shift the given matrix $k times.

  Each shift follow the rules:

  Rule 1:
  Element at grid[i][j] moves to grid[i][j + 1]
  This means every element moves one step to the right within its row.

  Rule 2:
  Element at grid[i][n - 1] moves to grid[i + 1][0]
  This handles the last column: elements in the last column of row i wrap to the
  first column of the next row (i+1).

  Rule 3:
  Element at grid[m - 1][n - 1] moves to grid[0][0]
  This is the bottom-right corner: it wraps to the top-left corner.

Example 1

  Input: @matrix = ([1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],)
         $k = 1
  Output: ([9, 1, 2],
           [3, 4, 5],
           [6, 7, 8],)

  Rule 1: grid[i][j] -> grid[i][j+1] for j < n-1.

  We take elements from the original grid at (i, j) and put them into
  new_grid[i][j+1].

  From original:

  (0,0): 1 -> new_grid[0][1] = 1
  (0,1): 2 -> new_grid[0][2] = 2
  (1,0): 4 -> new_grid[1][1] = 4
  (1,1): 5 -> new_grid[1][2] = 5
  (2,0): 7 -> new_grid[2][1] = 7
  (2,1): 8 -> new_grid[2][2] = 8

  New grid looks after Rule 1:

  ([?, 1, 2],
   [?, 4, 5],
   [?, 7, 8],)

  Rule 2: grid[i][n-1] -> grid[i+1][0] for i < m-1.

  Elements from original last column (except last row) go to next row's first
  column.

  From original:

  (0,2): 3 -> new_grid[1][0] = 3
  (1,2): 6 -> new_grid[2][0] = 6

  Now new grid after Rules 1 + 2:

  ([?, 1, 2],
   [3, 4, 5],
   [6, 7, 8],)

  Rule 3: grid[m-1][n-1] -> grid[0][0].

  Original (2,2): 9 -> new_grid[0][0] = 9.

  Now new_grid is complete:

  ([9, 1, 2],
   [3, 4, 5],
   [6, 7, 8],)

Example 2

  Input: @matrix = ([10, 20],
                    [30, 40],)
         $k = 1
  Output: ([40, 10],
           [20, 30],)

  Rule 1 (move right in same row if not last column):

  (0,0): 10 -> new[0][1] = 10
  (1,0): 30 -> new[1][1] = 30

  After Rule 1:

  ([?, 10],
   [?, 30],)

  Rule 2 (last col -> next row’s first col, except last row):

  (0,1): 20 -> new[1][0] = 20

  After Rule 2:

  ([?,  10],
   [20, 30],)

  Rule 3 (bottom-right to top-left):

  (1,1): 40 -> new[0][0] = 40

  After Rule 3:

  ([40, 10],
   [20, 30],)

Example 3

  Input: @matrix = ([1, 2],
                    [3, 4],
                    [5, 6],)
        $k = 1
  Output: ([6, 1],
           [2, 3],
           [4, 5],)

  Rule 1:
  (0,0): 1 -> new[0][1] = 1
  (1,0): 3 -> new[1][1] = 3
  (2,0): 5 -> new[2][1] = 5

  After Rule 1:
  ( [?, 1],
    [?, 3],
    [?, 5],)

  Rule 2:
  (0,1): 2 -> new[1][0] = 2
  (1,1): 4 -> new[2][0] = 4

  After Rule 2:
  ([?, 1],
   [2, 3],
   [4, 5],)

  Rule 3:
  (2,1): 6 -> new[0][0] = 6

  After Rule 3:
  ([6, 1],
   [2, 3],
   [4, 5],)

Example 4

  Input: @matrix = ([1, 2, 3],
                    [4, 5, 6],)
         $k = 5
  Output: ([2, 3, 4],
           [5, 6, 1],)

  Shift 1

  Rule 1
  1 -> (0,1)
  2 -> (0,2)
  4 -> (1,1)
  5 -> (1,2)

  Rule 2
  3 -> (1,0) (last column of row 0)

  Rule 3
  6 -> (0,0) (bottom-right corner)

  Result
  [6, 1, 2]
  [3, 4, 5]

  ----------------------------

  Shift 2

  Starting from the previous matrix:

  [6, 1, 2]
  [3, 4, 5]

  Rule 1
  6 -> (0,1)
  1 -> (0,2)
  3 -> (1,1)
  4 -> (1,2)

  Rule 2
  2 -> (1,0)

  Rule 3
  5 -> (0,0)

  Result
  [5, 6, 1]
  [2, 3, 4]

  ----------------------------

  Shift 3

  [5, 6, 1]
  [2, 3, 4]

  Rule 2: 1 -> (1,0)
  Rule 3: 4 -> (0,0)

  Others follow Rule 1

  Result
  [4, 5, 6]
  [1, 2, 3]

  ----------------------------

  Shift 4

  [4, 5, 6]
  [1, 2, 3]

  Result
  [3, 4, 5]
  [6, 1, 2]

  ----------------------------

  Shift 5
  [3, 4, 5]
  [6, 1, 2]

  Result
  [2, 3, 4]
  [5, 6, 1]

  Final Output (after k = 5 shifts)
  ([2, 3, 4],
   [5, 6, 1])

Example 5

  Input: @matrix = ([1, 2, 3, 4])
         $k = 1
  Output: ([4, 1, 2, 3])

  Rule 1:
  (0,0): 1 -> new[0][1] = 1
  (0,1): 2 -> new[0][2] = 2
  (0,2): 3 -> new[0][3] = 3

  After Rule 1:
  ([?, 1, 2, 3])

  Rule 2:
  (0,3): 4 -> new[1][0] ??

  Wait — but i=0, n-1=3, next row i+1=1 doesn’t exist (m=1).
  So this is actually a special case where Rule 2 should not apply.
  because m=1, so (0,3) goes by Rule 3 actually.

  The rules say:
  grid[i][j]     -> grid[i][j+1] for j < n-1.
  grid[i][n-1]   -> grid[i+1][0] for i < m-1.
  grid[m-1][n-1] -> grid[0][0].

  For m = 1:
  Elements (0,0),(0,1),(0,2) follow Rule 1 -> (0,1),(0,2),(0,3).
  Element (0,3) is (m-1, n-1), so follows Rule 3 -> (0,0).

  Actually, that means after Rule 1:
  We put 1,2,3 in positions 1,2,3, leaving position 0 empty.
  Then Rule 3 puts 4 in position 0.

  So final directly:
  [4, 1, 2, 3]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Matrix elements are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The shift count ($k) is entered on the command-line, followed by the input
   matrix, which is entered as a non-empty list of strings (the matrix rows),
   each containing the same (non-zero) number of integer elements separated by
   whitespace. For example, with $k = 3, the matrix:

        [ 1 2 3 ]
        [ 4 5 6 ]
        [ 7 8 9 ]

    is entered as: >raku ch-2.raku 3 "1 2 3" "4 5 6" "7 8 9"

Note
----
The matrix-handling code is derived from the solution to Perl Weekly Challenge
#266, Task 2: "X Matrix".

=end comment
#===============================================================================

use Test;

subset Matrix of Array where * ~~ Array[Array[Int]];
subset Pos    of Int   where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 354, Task #2: Shift Grid (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $k,                                        #= Shift count

    *@matrix where { .all ~~ Str:D && .elems > 0 }   #= Non-empty integer matrix
)
#===============================================================================
{
    my Matrix $matrix = parse-matrix( @matrix );

    print-matrix( 'Input:  @matrix = ', $matrix );
    "        \$k = $k".put;

    my Matrix $shifted = shift-matrix( $matrix, $k );

    print-matrix( 'Output: ', $shifted );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub shift-matrix( Matrix:D $matrix, Pos:D $k --> Matrix:D )
#-------------------------------------------------------------------------------
{
    my Matrix $shifted = $matrix;
    my Pos    $rows    = $matrix.elems;
    my Pos    $cols    = $matrix[0].elems;

    for 1 .. $k
    {
        my Int @elements;

        for 0 .. $shifted.end -> UInt $i
        {
            @elements.push: |$shifted[$i];
        }

        @elements.unshift: @elements.pop;

        $shifted = Array[Array[Int]].new;

        for 1 .. $rows
        {
            my Int @row;

            @row.push: @elements.shift for 1 .. $cols;

            $shifted.push: @row;
        }

        @elements.elems == 0 or die 'Impossible case';
    }

    return $shifted;
}

#-------------------------------------------------------------------------------
sub parse-matrix( List:D[Str:D] $rows --> Matrix:D )
#-------------------------------------------------------------------------------
{
    my Matrix $matrix = Array[Array[Int]].new;
    my UInt   $cols;

    for @$rows -> Str $row-str
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

        @row.elems > 0          or error( 'Empty row' );
        $matrix.push: @row;

        if $cols.defined
        {
            @row.elems == $cols or error( 'The input matrix is ragged' );
        }
        else    # Initialize $cols
        {
            $cols = @row.elems;
        }
    }

    return $matrix;
}

#-------------------------------------------------------------------------------
sub print-matrix( Str:D $prefix, Matrix:D $matrix )
#-------------------------------------------------------------------------------
{
    my Str  $tab   = ' ' x $prefix.chars;
    my UInt @width = 1  xx $matrix[0].elems;

    for @$matrix -> Int @row
    {
        for 0 .. @row.end -> UInt $i
        {
            my UInt $w = @row[$i].chars;

            @width[$i] = $w if $w > @width[$i];
        }
    }

    "$prefix\(".print;
    my Bool $first = True;

    for @$matrix -> Int @row
    {
        my Str @row-str;

        for 0 .. @row.end -> UInt $i
        {
            @row-str.push: '%*d'.sprintf: @width[$i], @row[$i];
        }

        if $first
        {
            "[%s]".printf: @row-str.join: ', ';
            $first = False;
        }
        else
        {
            "\n%s [%s]".printf: $tab, @row-str.join: ', ';
        }
    }

    ')'.put;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $k, $expctd-str) = $line.split: / \| /;

        for     $test-name, $matrix-str, $k, $expctd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Matrix $matrix   = parse-matrix( $matrix-str.split( / \; / ).list );
        my Matrix $shifted  = shift-matrix( $matrix, $k.Int );
        my Matrix $expected = parse-matrix( $expctd-str.split( / \; / ).list );

        is-deeply $shifted, $expected, $test-name;
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
        Example 1|1 2 3; 4 5 6; 7 8 9|1|9 1 2; 3 4 5; 6 7 8
        Example 2|10 20; 30 40       |1|40 10; 20 30
        Example 3|1 2; 3 4; 5 6      |1|6 1; 2 3; 4 5
        Example 4|1 2 3; 4 5 6       |5|2 3 4; 5 6 1
        Example 5|1 2 3 4            |1|4 1 2 3
        Minimal  |0                  |1|0
        END
}

################################################################################
