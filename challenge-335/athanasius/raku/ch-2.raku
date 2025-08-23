use v6d;

################################################################################
=begin comment

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
2. A non-empty list of move coordinates (0, 1, or 2) is entered on the command-
   line. For example, the moves [0,0],[1,1] are entered as follows:
   
       >raku ch-2.raku 0 0 1 1

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

=end comment
#===============================================================================

use Test;

subset Index  of Int  where 2 >= * >= 0;
subset Move   of List where (Index, Index);
subset Square of Str  where { $_ eq < A B _ >.any };
subset Row    of List where (Square, Square, Square);
subset Grid   of List where (Row, Row, Row);
subset Winner of Str  where { $_ eq < A B Draw Pending >.any };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 335, Task #2: Find Winner (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| List of move coordinates, e.g., 0 0 2 0 1 1 2 1 2 2

    *@coords where { .elems > 0 && .elems %% 2 && .all ~~ Index:D }
)
#===============================================================================
{
    my Move @moves = get-moves( @coords );

    "Input:  \@moves = (%s)\n".printf:
              @moves.map( { '[' ~ .join( ', ' ) ~ ']' } ).join: ', ';

    my (Winner $winner, Grid $grid) = find-winner( @moves );

    "Output: $winner\n\nGame Board:".put;

    "[ %s %s %s ]\n".printf: @$_ for @$grid;

    CATCH
    {
        when X::AdHoc
        {
            "\n%s\n".printf: .message;
            exit 0;
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-winner( List:D[Move:D] $moves --> List:D[Winner:D, Grid:D] )
#-------------------------------------------------------------------------------
{
    my Winner $winner = 'Pending';
    my Grid   $grid   = [ [ '_' xx 3 ] xx 3 ];
    my Str    $player = 'A';

    for @$moves -> Move $move
    {
        my  Index ($row, $col) = @$move;

        if  $grid[ $row; $col ] eq '_'
        {
            $grid[ $row; $col ] = $player;
        }
        else
        {
            die "ERROR: Illegal move: [$row, $col]";
        }

        $winner = check-grid( $grid );

        last unless $winner eq 'Pending';

        $player = $player eq 'A' ?? 'B' !! 'A';
    }

    return $winner, $grid;
}

#-------------------------------------------------------------------------------
sub check-grid( Grid:D $grid --> Winner:D )
#-------------------------------------------------------------------------------
{
    # Has the game been won? Test columns first, then rows, then diagonals

    for [ 0, 0, 0, 1, 0, 2 ], [ 1, 0, 1, 1, 1, 2 ], [ 2, 0, 2, 1, 2, 2 ],
        [ 0, 0, 1, 0, 2, 0 ], [ 0, 1, 1, 1, 2, 1 ], [ 0, 2, 1, 2, 2, 2 ],
        [ 0, 0, 1, 1, 2, 2 ], [ 0, 2, 1, 1, 2, 0 ] -> Array $coords
    {
        if line-complete( $coords, $grid )
        {
            return $grid[ $coords[ 0 ]; $coords[ 1 ] ];         # Winner
        }
    }

    # No winner yet; is the game drawn?

    for 0 .. 2 -> UInt $i
    {
        for 0 .. 2 -> UInt $j
        {
            return 'Pending' if $grid[ $i; $j ] eq '_';         # No
        }
    }

    return 'Draw';                                              # Yes
}

#-------------------------------------------------------------------------------
sub line-complete( List:D[Index:D] $coords, Grid:D $grid --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str $square-a = $grid[ $coords[ 0 ] ][ $coords[ 1 ] ];
    my Str $square-b = $grid[ $coords[ 2 ] ][ $coords[ 3 ] ];
    my Str $square-c = $grid[ $coords[ 4 ] ][ $coords[ 5 ] ];

    return ($square-a eq 'A' || $square-a eq 'B') &&
            $square-a eq $square-b                &&
            $square-a eq $square-c;
}

#-------------------------------------------------------------------------------
sub get-moves
(
    List:D[Index:D] $coords where { .elems %% 2 }
--> List:D[Move:D]
)
#-------------------------------------------------------------------------------
{
    return $coords.rotor( 2 ).map( { [ +$_[ 0 ], +$_[ 1 ] ] } ).list;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $moves-str, $expected) = $line.split: / \| /;

        for     $test-name, $moves-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my  Index  @coords = $moves-str.split( / \s+ || \, /, :skip-empty )
                                       .map: { .Int };
        my  Move   @moves  = get-moves( @coords );
        my (Winner $winner, Grid) = find-winner( @moves );

        is $winner, $expected, $test-name;
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
        Example 1|0,0 2,0 1,1 2,1 2,2                |A
        Example 2|0,0 1,1 0,1 0,2 1,0 2,0            |B
        Example 3|0,0 1,1 2,0 1,0 1,2 2,1 0,1 0,2 2,2|Draw
        Example 4|0,0 1,1                            |Pending
        Example 5|1,1 0,0 2,2 0,1 1,0 0,2            |B
        END
}

################################################################################
