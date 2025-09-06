#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Matrix dimensions (rows and columns) are entered on the command-line, follow-
   ed by a list of coordinates describing positions within the matrix. The co-
   ordinates are 0-indexed (row, column) integer pairs.
   
=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( natatime );
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <row> <col> [<coords> ...]
  perl $0

    <row>             Number of matrix rows
    <col>             Number of matrix columns
    [<coords> ...]    A list of matrix coordinate pairs
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 337, Task #2: Odd Matrix (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my ($row, $col, $positions) = parse_input( @ARGV );

        printf "Input:  \$row = $row, \$col = $col, \@locations = (%s)\n",
                join ',', map { '[' . join( ',', @$_ ) . ']' } @$positions;

        my $odd = odd_cells( $row, $col, $positions );

        print "Output: $odd\n";
    }
}

#-------------------------------------------------------------------------------
sub odd_cells
#-------------------------------------------------------------------------------
{
    my  ($row, $col, $positions) = @_;
    my   @matrix;
    push @matrix, [(0) x $col] for 1 .. $row;

    for my $coord (@$positions)
    {
        ++$matrix[ $coord->[0] ][$_] for 0 .. $col - 1;
        ++$matrix[$_][ $coord->[1] ] for 0 .. $row - 1;
    }

    my $odd = 0;

    for my $i (0 .. $row - 1)
    {
        for my $j (0 .. $col - 1)
        {
            ++$odd unless $matrix[$i][$j] % 2 == 0;
        }
    }

    return $odd;
}

#-------------------------------------------------------------------------------
sub parse_input
#-------------------------------------------------------------------------------
{
    my  ($row, $col, @coords) = @_;

    for ($row, $col, @coords)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    $row > 0                   or error( 'Invalid row value'         );
    $col > 0                   or error( 'Invalid column value'      );
    scalar @coords % 2 == 0    or error( 'Odd number of coordinates' );

    my @positions;
    my $it = natatime 2, @coords;

    while (my @c = $it->())
    {
        0 <= $c[0] <= $row     or error( 'Invalid row coordinate '    . $c[0] );
        0 <= $c[1] <= $col     or error( 'Invalid column coordinate ' . $c[1] );

        push @positions, [ @c ];
    }

    return ($row, $col, \@positions);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $row, $col, $positions_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $row, $col, $positions_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @coordinates = split / \s+ | , /x, $positions_str;
        my $positions;
          ($row, $col, $positions) = parse_input( $row, $col, @coordinates );
        my $odd = odd_cells( $row, $col, $positions );

        is $odd, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|2|3|0,1 1,1        |6
Example 2|2|2|1,1 0,0        |0
Example 3|3|3|0,0 1,2 2,1    |0
Example 4|1|5|0,2 0,4        |2
Example 5|4|2|1,0 3,1 2,0 0,1|8
Minimal  |1|1|               |0
