use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 337
=========================

TASK #2
-------
*Odd Matrix*

Submitted by: Mohammad Sajid Anwar

You are given row and col, also a list of positions in the matrix.

Write a script to perform action on each location (0-indexed) as provided in the
list and find out the total odd valued cells.

For each location (r, c), do both of the following:

  a) Increment by 1 all the cells on row r.
  b) Increment by 1 all the cells on column c.

Example 1

  Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
  Output: 6

  Initial:
  [ 0 0 0 ]
  [ 0 0 0 ]

  Apply [0,1]:
  Increment row 0:
  Before     After
  [ 0 0 0 ]  [ 1 1 1 ]
  [ 0 0 0 ]  [ 0 0 0 ]
  Increment col 1:
  Before     After
  [ 1 1 1 ]  [ 1 2 1 ]
  [ 0 0 0 ]  [ 0 1 0 ]

  Apply [1,1]:
  Increment row 1:
  Before     After
  [ 1 2 1 ]  [ 1 2 1 ]
  [ 0 1 0 ]  [ 1 2 1 ]
  Increment col 1:
  Before     After
  [ 1 2 1 ]  [ 1 3 1 ]
  [ 1 2 1 ]  [ 1 3 1 ]

  Final:
  [ 1 3 1 ]
  [ 1 3 1 ]

Example 2

  Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
  Output: 0

  Initial:
  [ 0 0 ]
  [ 0 0 ]

  Apply [1,1]:
  Increment row 1:
  Before    After
  [ 0 0 ]   [ 0 0 ]
  [ 0 0 ]   [ 1 1 ]
  Increment col 1:
  Before    After
  [ 0 0 ]   [ 0 1 ]
  [ 1 1 ]   [ 1 2 ]

  Apply [0,0]:
  Increment row 0:
  Before    After
  [ 0 1 ]   [ 1 2 ]
  [ 1 2 ]   [ 1 2 ]
  Increment col 0:
  Before    After
  [ 1 2 ]   [ 2 2 ]
  [ 1 2 ]   [ 2 2 ]

  Final:
  [ 2 2 ]
  [ 2 2 ]

Example 3

  Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
  Output: 0

  Initial:
  [ 0 0 0 ]
  [ 0 0 0 ]
  [ 0 0 0 ]

  Apply [0,0]:
  Increment row 0:
  Before     After
  [ 0 0 0 ]  [ 1 1 1 ]
  [ 0 0 0 ]  [ 0 0 0 ]
  [ 0 0 0 ]  [ 0 0 0 ]
  Increment col 0:
  Before     After
  [ 1 1 1 ]  [ 2 1 1 ]
  [ 0 0 0 ]  [ 1 0 0 ]
  [ 0 0 0 ]  [ 1 0 0 ]

  Apply [1,2]:
  Increment row 1:
  Before     After
  [ 2 1 1 ]  [ 2 1 1 ]
  [ 1 0 0 ]  [ 2 1 1 ]
  [ 1 0 0 ]  [ 1 0 0 ]
  Increment col 2:
  Before     After
  [ 2 1 1 ]  [ 2 1 2 ]
  [ 2 1 1 ]  [ 2 1 2 ]
  [ 1 0 0 ]  [ 1 0 1 ]

  Apply [2,1]:
  Increment row 2:
  Before     After
  [ 2 1 2 ]  [ 2 1 2 ]
  [ 2 1 2 ]  [ 2 1 2 ]
  [ 1 0 1 ]  [ 2 1 2 ]
  Increment col 1:
  Before     After
  [ 2 1 2 ]  [ 2 2 2 ]
  [ 2 1 2 ]  [ 2 2 2 ]
  [ 2 1 2 ]  [ 2 2 2 ]

  Final:
  [ 2 2 2 ]
  [ 2 2 2 ]
  [ 2 2 2 ]

Example 4

  Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
  Output: 2

  Initial:
  [ 0 0 0 0 0 ]

  Apply [0,2]:
  Increment row 0:
  Before         After
  [ 0 0 0 0 0 ]  [ 1 1 1 1 1 ]
  Increment col 2:
  Before         After
  [ 1 1 1 1 1 ]  [ 1 1 2 1 1 ]

  Apply [0,4]:
  Increment row 0:
  Before         After
  [ 1 1 2 1 1 ]  [ 2 2 3 2 2 ]
  Increment col 4:
  Before         After
  [ 2 2 3 2 2 ]  [ 2 2 3 2 3 ]

  Final:
  [ 2 2 3 2 3 ]

Example 5

  Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
  Output: 8

Initial:
  [ 0 0 ]
  [ 0 0 ]
  [ 0 0 ]
  [ 0 0 ]

  Apply [1,0]:
  Increment row 1:
  Before     After
  [ 0 0 ]    [ 0 0 ]
  [ 0 0 ]    [ 1 1 ]
  [ 0 0 ]    [ 0 0 ]
  [ 0 0 ]    [ 0 0 ]
  Increment col 0:
  Before     After
  [ 0 0 ]    [ 1 0 ]
  [ 1 1 ]    [ 2 1 ]
  [ 0 0 ]    [ 1 0 ]
  [ 0 0 ]    [ 1 0 ]

  Apply [3,1]:
  Increment row 3:
  Before     After
  [ 1 0 ]    [ 1 0 ]
  [ 2 1 ]    [ 2 1 ]
  [ 1 0 ]    [ 1 0 ]
  [ 1 0 ]    [ 2 1 ]
  Increment col 1:
  Before     After
  [ 1 0 ]    [ 1 1 ]
  [ 2 1 ]    [ 2 2 ]
  [ 1 0 ]    [ 1 1 ]
  [ 2 1 ]    [ 2 2 ]

  Apply [2,0]:
  Increment row 2:
  Before     After
  [ 1 1 ]    [ 1 1 ]
  [ 2 2 ]    [ 2 2 ]
  [ 1 1 ]    [ 2 2 ]
  [ 2 2 ]    [ 2 2 ]
  Increment col 0:
  Before     After
  [ 1 1 ]    [ 2 1 ]
  [ 2 2 ]    [ 3 2 ]
  [ 2 2 ]    [ 3 2 ]
  [ 2 2 ]    [ 3 2 ]

  Apply [0,1]:
  Increment row 0:
  Before     After
  [ 2 1 ]    [ 3 2 ]
  [ 3 2 ]    [ 3 2 ]
  [ 3 2 ]    [ 3 2 ]
  [ 3 2 ]    [ 3 2 ]
  Increment col 1:
  Before     After
  [ 3 2 ]    [ 3 3 ]
  [ 3 2 ]    [ 3 3 ]
  [ 3 2 ]    [ 3 3 ]
  [ 3 2 ]    [ 3 3 ]

  Final:
  [ 3 3 ]
  [ 3 3 ]
  [ 3 3 ]
  [ 3 3 ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Matrix dimensions (rows and columns) are entered on the command-line, follow-
   ed by a list of coordinates describing positions within the matrix. The co-
   ordinates are 0-indexed (row, column) integer pairs.

=end comment
#===============================================================================

use Test;

subset Coord of List where (UInt, UInt);
subset Pos   of Int  where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 337, Task #2: Odd Matrix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $row,                 #= Number of matrix rows
    Pos:D $col,                 #= Number of matrix columns

    #| A list of matrix coordinate pairs

         *@coords where { .elems %% 2 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \$row = $row, \$col = $col, \@locations = (%s)\n".printf:
        @coords.rotor( 2 ).map( { '[' ~ .join( ',' ) ~ ']' } ).join: ',';

    my Coord @positions;

    for @coords.rotor( 2 ) -> Coord $coord
    {
        my UInt ($r, $c) = $coord;

        $row >= $r or error( qq[Row coordinate "$r" too large] );
        $col >= $c or error( qq[Col coordinate "$c" too large] );

        @positions.push: [$r, $c];
    }

    my UInt $odd = odd-cells( $row, $col, @positions );

    "Output: $odd".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub odd-cells( UInt:D $row, UInt:D $col, List:D[Coord:D] @positions --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Array[UInt] @matrix = Array[UInt].new( 0 xx $col ) xx $row;

    for @positions -> Coord $coord
    {
        ++@matrix[ $coord[ 0 ]; $_ ] for 0 .. $col - 1;
        ++@matrix[ $_; $coord[ 1 ] ] for 0 .. $row - 1;
    }

    my UInt $odd = 0;

    for 0 .. $row - 1 -> UInt $i
    {
        for 0 .. $col - 1 -> UInt $j
        {
            ++$odd unless @matrix[$i; $j] %% 2;
        }
    }

    return $odd;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $row, $col, $positions-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $row, $col, $positions-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str   @pos-strs  = $positions-str.split: / \s+ /, :skip-empty;
        my Coord @positions = @pos-strs.map:
                              {
                                  Array[UInt].new:
                                  .split( / \, / ).map: { .Int }
                              };
        my UInt  $odd       = odd-cells( $row.Int, $col.Int, @positions );

        is $odd, $expected.Int, $test-name;
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
        Example 1|2|3|0,1 1,1        |6
        Example 2|2|2|1,1 0,0        |0
        Example 3|3|3|0,0 1,2 2,1    |0
        Example 4|1|5|0,2 0,4        |2
        Example 5|4|2|1,0 3,1 2,0 0,1|8
        Minimal  |1|1|               |0
        END
}

################################################################################
