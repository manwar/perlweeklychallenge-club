#!perl

################################################################################
=comment

Perl Weekly Challenge 335
=========================

TASK #2
-------
*Find Winner*

Submitted by: Mohammad Sajid Anwar

You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on the
moves provided in the given array.

UPDATE: Order move is in the order - A, B, A, B, A, ….

Example 1

  Input: @moves = ([0,0],[2,0],[1,1],[2,1],[2,2])
  Output: A

  Game Board:
  [ A _ _ ]
  [ B A B ]
  [ _ _ A ]

Example 2

  Input: @moves = ([0,0],[1,1],[0,1],[0,2],[1,0],[2,0])
  Output: B

  Game Board:
  [ A A B ]
  [ A B _ ]
  [ B _ _ ]

Example 3

  Input: @moves = ([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2])
  Output: Draw

  Game Board:
  [ A A B ]
  [ B B A ]
  [ A B A ]

Example 4

  Input: @moves = ([0,0],[1,1])
  Output: Pending

  Game Board:
  [ A _ _ ]
  [ _ B _ ]
  [ _ _ _ ]

Example 5

  Input: @moves = ([1,1],[0,0],[2,2],[0,1],[1,0],[0,2])
  Output: B

  Game Board:
  [ B B B ]
  [ A A _ ]
  [ _ _ A ]

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
2. A non-empty list of move coordinates (0, 1, or 2) is entered on the command-
   line. For example, the moves [0,0],[1,1] are entered as follows:
   
       >perl ch-2.pl 0 0 1 1

Assumptions
-----------
1. A move to a square already filled is an error, as is a move to a nonexistent
   square.
2. Even if it is not winnable, a game is not considered Drawn until all the
   squares have been filled.
3. Once the game has been decided (won or drawn), any further moves are simply
   ignored.
4. The Game Board for Example 1 is incorrect; it should be:
   [ A _ _ ]
   [ _ A _ ]
   [ B B A ]

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util   qw( pairs  );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<coords> ...]
  perl $0

    [<coords> ...]    List of move coordinates, e.g., 0 0 2 0 1 1 2 1 2 2
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 335, Task #2: Find Winner (Perl)\n\n";
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
    elsif ($argc % 2 == 1)
    {
        error( 'Expected an even number of command-line arguments, found ' .
                $argc );
    }
    else
    {
        my @coords = @ARGV;

        / ^ [012] $ /x or error( qq[Invalid coordinate "$_"] ) for @coords;

        my @moves = get_moves( \@coords );

        printf "Input:  \@moves = (%s)\n",
                join ', ', map { '[' . join( ', ', @$_ ) . ']'  } @moves;

        my ($winner, $grid) = find_winner( \@moves );

        print  "Output: $winner\n\nGame Board:\n";

        printf "[ %s %s %s ]\n", @$_ for @$grid;
    }
}

#-------------------------------------------------------------------------------
sub find_winner
#-------------------------------------------------------------------------------
{
    my  ($moves) = @_;
    my   $winner = 'Pending';
    my   $player = 'A';
    my   @grid;
    push @grid, [ ('_') x 3 ] for 1 .. 3;

    for my $move (@$moves)
    {
        my ($row, $col) = @$move;

        if ($grid[ $row ][ $col ] eq '_')
        {
            $grid[ $row ][ $col ] = $player;
        }
        else
        {
            die "\nERROR: Illegal move: [$row, $col]\n";
        }

        $winner = check_grid( \@grid );

        last unless $winner eq 'Pending';

        $player = $player eq 'A' ? 'B' : 'A';
    }

    return ($winner, \@grid);
}

#-------------------------------------------------------------------------------
sub check_grid
#-------------------------------------------------------------------------------
{
    my ($grid) = @_;

    # Has the game been won? Test columns first, then rows, then diagonals

    for my $coords ([ 0, 0, 0, 1, 0, 2 ], [ 1, 0, 1, 1, 1, 2 ],
                    [ 2, 0, 2, 1, 2, 2 ], [ 0, 0, 1, 0, 2, 0 ],
                    [ 0, 1, 1, 1, 2, 1 ], [ 0, 2, 1, 2, 2, 2 ],
                    [ 0, 0, 1, 1, 2, 2 ], [ 0, 2, 1, 1, 2, 0 ])
    {
        if (line_complete( $coords, $grid ))
        {
            return $grid->[ $coords->[ 0 ] ][ $coords->[ 1 ] ];     # Winner
        }
    }

    # No winner yet; is the game drawn?

    for my $i (0 .. 2)
    {
        for my $j (0 .. 2)
        {
            return 'Pending' if $grid->[ $i ][ $j ] eq '_';         # No
        }
    }

    return 'Draw';                                                  # Yes
}

#-------------------------------------------------------------------------------
sub line_complete
#-------------------------------------------------------------------------------
{
    my ($coords, $grid) = @_;

    my  $square_a = $grid->[ $coords->[ 0 ] ][ $coords->[ 1 ] ];
    my  $square_b = $grid->[ $coords->[ 2 ] ][ $coords->[ 3 ] ];
    my  $square_c = $grid->[ $coords->[ 4 ] ][ $coords->[ 5 ] ];

    return ($square_a eq 'A' || $square_a eq 'B') &&
            $square_a eq $square_b                &&
            $square_a eq $square_c;
}

#-------------------------------------------------------------------------------
sub get_moves
#-------------------------------------------------------------------------------
{
    my ($coords) = @_;

    return map { [ @$_ ] } pairs @$coords;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $moves_str, $expected) = split / \| /x, $line;

        for ($test_name, $moves_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @coords         = split / [\s,]+ /x, $moves_str;
        my  @moves          = get_moves  ( \@coords );
        my ($winner, undef) = find_winner( \@moves  );

        is $winner, $expected, $test_name;
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
Example 1|0,0 2,0 1,1 2,1 2,2                |A
Example 2|0,0 1,1 0,1 0,2 1,0 2,0            |B
Example 3|0,0 1,1 2,0 1,0 1,2 2,1 0,1 0,2 2,2|Draw
Example 4|0,0 1,1                            |Pending
Example 5|1,1 0,0 2,2 0,1 1,0 0,2            |B
