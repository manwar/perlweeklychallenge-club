#!perl

################################################################################
=comment

Perl Weekly Challenge 281
=========================

TASK #2
-------
*Knight's Move*

Submitted by: Peter Campbell Smith

A Knight in chess can move from its current position to any square two rows or
columns plus one column or row away. So in the diagram below, if it starts at S,
it can move to any of the squares marked E.

Write a script which takes a starting position and an ending position and
calculates the least number of moves required.

    ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
  8 │ a8  │     │     │     │     │     │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  7 │     │     │  E  │  ↔  │  E  │     │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  6 │     │  E  │     │  ↑  │     │  E  │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  5 │     │  ↕  │  ←  │  S  │  →  │  ↕  │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  4 │     │  E  │     │  ↓  │     │  E  │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  3 │     │     │  E  │  ↔  │  E  │     │     │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  2 │     │     │     │     │     │     │ g2  │     │
    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
  1 │     │     │     │     │     │     │     │     │
    └─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
       a     b     c     d     e     f     g     h

  Week_281_Task_2

Example 1

  Input: $start = 'g2', $end = 'a8'
  Output: 4

  g2 -> e3 -> d5 -> c7 -> a8

Example 2

  Input: $start = 'g2', $end = 'h2'
  Output: 3

  g2 -> e3 -> f1 -> h2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output (i.e., one possible solution) is desired,
   "--verbose" is entered as a command-line flag.
3. The starting and ending squares for the knight's moves are entered on the
   command-line. Each is a single, two-character string, comprising a file name
   ("a" through "h") followed by a rank number (1 through 8).
4. If it is desired to display the final state of the chessboard, including all
   knight moves considered so far, at the point where the (first) solution is
   found, the constant $DEBUG is set to a true value. This also enables the
   verbose option.

Notes
-----
For any two squares S and E, the minimum number of knight moves required to
travel from S to E ranges from 0 (when S = E) to 6 (e.g., a1 to h8).

For speed, all possible knight moves have been pre-computed and stored in a
hash. A 2-dimensional array representing the chess board is used to keep track
of knight moves as they are made. A list of most recent moves (initially just S)
is also maintained.

For the first move, the squares (2 to 8 in number, depending on the position of
S on the board) reachable from S by a single knight move are recorded on the
board by entering the coordinates of S in those squares. For example, if S is a1
then the first move is either to b3 or to c2; therefore, "a1" is entered at
positions b3 and c2 to record these moves.

For the second and subsequent moves, each square reached on the previous move is
taken as the starting point for a new set of moves. However, a move to a square
that has already been reached is discarded.

The search ends when a move reaches E. At this point, the sequence of moves is
traced backwards from E to S, giving the path of the solution. Although this
solution is not necessarily unique, it is guaranteed to be a minimal solution.

=cut
#===============================================================================

use v5.32;        # Enables strictures and warnings
use utf8;
use open          qw( :std :encoding(UTF-8) );
use Const::Fast;
use Getopt::Long;
use Test::More;
use enum          qw( Failed Added Found );        # The result of attempting to
                                                   # record a new knight move
const my $DEBUG  => 1;
const my $EMPTY  => '  ';
const my $END    => 'E ';
const my $START  => 'S ';
const my $USAGE  => <<END;
Usage:
  perl $0 [--verbose] <start> <end>
  perl $0

    --verbose    Display the knight's moves? [default: False]
    <start>      Knight's starting square (e.g., "g2")
    <end>        Knight's destination     (e.g., "a8")
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 281, Task #2: Knight's Move (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($verbose, $start, $end) = parse_command_line();

        print  "Input:  \$start = '$start', \$end = '$end'\n";

        my $moves = find_moves( $start, $end, $DEBUG );

        printf "Output: %d\n", scalar( @$moves ) - 1;

        printf( "\n%s\n", join ' -> ', @$moves ) if $verbose || $DEBUG;
    }
}

#-------------------------------------------------------------------------------
sub find_moves
#-------------------------------------------------------------------------------
{
    my ($start, $end, $debug) = @_;
    my  @solution = $start;

    if ($start ne $end)
    {
        my $board  = init_board( $start, $end );
        my @leaves = $start;

        L_MAIN_LOOP: while (1)
        {
            my @new_leaves;

            for my $leaf (@leaves)
            {
                for my $move (get_knight_moves( $leaf )->@*)
                {
                    my $result = record_move( $board, $move, $leaf );

                    last L_MAIN_LOOP        if $result == Found;
                    push @new_leaves, $move if $result == Added;
                }
            }

            @leaves = @new_leaves;
        }

        @solution = trace_solution( $board, $start, $end, $debug );
    }

    return \@solution;
}

#-------------------------------------------------------------------------------
sub init_board
#-------------------------------------------------------------------------------
{
    my ($start, $end) = @_;
    my  $board;

    for my $file (0 .. 7)
    {
        $board->[ $file ] = [ ($EMPTY) x 8 ];
    }

    $board->[ file( $start ) ][ rank( $start ) ] = $START;
    $board->[ file( $end   ) ][ rank( $end   ) ] = $END;

    return $board;
}

#-------------------------------------------------------------------------------
sub get_knight_moves
#-------------------------------------------------------------------------------
{
    const my %KNIGHT_MOVES =>
    (
        a1 => [ qw( b3 c2                   ) ],
        a2 => [ qw( b4 c3 c1                ) ],
        a3 => [ qw( b5 c4 c2 b1             ) ],
        a4 => [ qw( b6 c5 c3 b2             ) ],
        a5 => [ qw( b7 c6 c4 b3             ) ],
        a6 => [ qw( b8 c7 c5 b4             ) ],
        a7 => [ qw(    c8 c6 b5             ) ],
        a8 => [ qw(       c7 b6             ) ],

        b1 => [ qw(    a3 c3 d2             ) ],
        b2 => [ qw(    a4 c4 d3 d1          ) ],
        b3 => [ qw( a1 a5 c5 d4 d2 c1       ) ],
        b4 => [ qw( a2 a6 c6 d5 d3 c2       ) ],
        b5 => [ qw( a3 a7 c7 d6 d4 c3       ) ],
        b6 => [ qw( a4 a8 c8 d7 d5 c4       ) ],
        b7 => [ qw( a5       d8 d6 c5       ) ],
        b8 => [ qw( a6          d7 c6       ) ],

        c1 => [ qw(       a2 b3 d3 e2       ) ],
        c2 => [ qw(    a1 a3 b4 d4 e3 e1    ) ],
        c3 => [ qw( b1 a2 a4 b5 d5 e4 e2 d1 ) ],
        c4 => [ qw( b2 a3 a5 b6 d6 e5 e3 d2 ) ],
        c5 => [ qw( b3 a4 a6 b7 d7 e6 e4 d3 ) ],
        c6 => [ qw( b4 a5 a7 b8 d8 e7 e5 d4 ) ],
        c7 => [ qw( b5 a6 a8       e8 e6 d5 ) ],
        c8 => [ qw( b6 a7             e7 d6 ) ],

        d1 => [ qw(       b2 c3 e3 f2       ) ],
        d2 => [ qw(    b1 b3 c4 e4 f3 f1    ) ],
        d3 => [ qw( c1 b2 b4 c5 e5 f4 f2 e1 ) ],
        d4 => [ qw( c2 b3 b5 c6 e6 f5 f3 e2 ) ],
        d5 => [ qw( c3 b4 b6 c7 e7 f6 f4 e3 ) ],
        d6 => [ qw( c4 b5 b7 c8 e8 f7 f5 e4 ) ],
        d7 => [ qw( c5 b6 b8       f8 f6 e5 ) ],
        d8 => [ qw( c6 b7             f7 e6 ) ],

        e1 => [ qw(       c2 d3 f3 g2       ) ],
        e2 => [ qw(    c1 c3 d4 f4 g3 g1    ) ],
        e3 => [ qw( d1 c2 c4 d5 f5 g4 g2 f1 ) ],
        e4 => [ qw( d2 c3 c5 d6 f6 g5 g3 f2 ) ],
        e5 => [ qw( d3 c4 c6 d7 f7 g6 g4 f3 ) ],
        e6 => [ qw( d4 c5 c7 d8 f8 g7 g5 f4 ) ],
        e7 => [ qw( d5 c6 c8       g8 g6 f5 ) ],
        e8 => [ qw( d6 c7             g7 f6 ) ],

        f1 => [ qw(       d2 e3 g3 h2       ) ],
        f2 => [ qw(    d1 d3 e4 g4 h3 h1    ) ],
        f3 => [ qw( e1 d2 d4 e5 g5 h4 h2 g1 ) ],
        f4 => [ qw( e2 d3 d5 e6 g6 h5 h3 g2 ) ],
        f5 => [ qw( e3 d4 d6 e7 g7 h6 h4 g3 ) ],
        f6 => [ qw( e4 d5 d7 e8 g8 h7 h5 g4 ) ],
        f7 => [ qw( e5 d6 d8       h8 h6 g5 ) ],
        f8 => [ qw( e6 d7             h7 g6 ) ],

        g1 => [ qw(       e2 f3 h3          ) ],
        g2 => [ qw(    e1 e3 f4 h4          ) ],
        g3 => [ qw( f1 e2 e4 f5 h5 h1       ) ],
        g4 => [ qw( f2 e3 e5 f6 h6 h2       ) ],
        g5 => [ qw( f3 e4 e6 f7 h7 h3       ) ],
        g6 => [ qw( f4 e5 e7 f8 h8 h4       ) ],
        g7 => [ qw( f5 e6 e8       h5       ) ],
        g8 => [ qw( f6 e7          h6       ) ],

        h1 => [ qw(       f2 g3             ) ],
        h2 => [ qw(    f1 f3 g4             ) ],
        h3 => [ qw( g1 f2 f4 g5             ) ],
        h4 => [ qw( g2 f3 f5 g6             ) ],
        h5 => [ qw( g3 f4 f6 g7             ) ],
        h6 => [ qw( g4 f5 f7 g8             ) ],
        h7 => [ qw( g5 f6 f8                ) ],
        h8 => [ qw( g6 f7                   ) ]
    );

    my ($position) = @_;

    return $KNIGHT_MOVES{ $position };
}

#-------------------------------------------------------------------------------
sub record_move
#-------------------------------------------------------------------------------
{
    my ($board, $move, $origin) = @_;
    my  $result = Failed;
    my  $file   = file( $move );
    my  $rank   = rank( $move );
    my  $square = $board->[ $file ][ $rank ];

    if ($square eq $END || $square eq $EMPTY)
    {
        $board->[ $file ][ $rank ] = $origin;

        $result = ($square eq $END) ? Found : Added;
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub trace_solution
#-------------------------------------------------------------------------------
{
    my ($board, $start, $end, $debug) = @_;

    display( $board, $start, $end ) if $debug;

    my @solution = $end;

    until ($solution[ 0 ] eq $start)
    {
        my $file = file( $solution[ 0 ] );
        my $rank = rank( $solution[ 0 ] );

        unshift @solution, $board->[ $file ][ $rank ];
    }

    return @solution;
}

#-------------------------------------------------------------------------------
sub file       # Get the given square's file index, e.g., "a1" --> 0, "h5" --> 7
#-------------------------------------------------------------------------------
{
    my ($square) = @_;

    return ord( substr $square, 0, 1 ) - ord( 'a' );
}

#-------------------------------------------------------------------------------
sub rank       # Get the given square's rank index, e.g., "a1" --> 0, "h5" --> 4
#-------------------------------------------------------------------------------
{
    my ($square) = @_;

    return substr( $square, 1, 1 ) - 1;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $verbose;

    GetOptions
    (
        verbose => \$verbose

    )       or error( 'Invalid command-line argument' );

    my $argc = scalar @ARGV;

    $argc == 2
            or error( "Expected 0 or 2 command-line arguments, found $argc" );

    my  ($start, $end) = @ARGV;

    for ($start, $end)
    {
        / ^ [a-h] [1-8] $ /x
            or error( qq[Invalid coordinates "$_"] );
    }

    return ($verbose, $start, $end);
}

#-------------------------------------------------------------------------------
sub display
#-------------------------------------------------------------------------------
{
    # This routine is provided for debugging: it prints the current contents of
    # the chessboard (i.e., all knight moves recorded so far) to the console

    my ($board, $start, $end) = @_;

    print "\n    ┌────┬────┬────┬────┬────┬────┬────┬────┐\n";

    for my $rank (reverse 0 .. 7)
    {
        printf '  %d │', $rank + 1;

        for my $file (0 .. 7)
        {
            printf ' %s │', $board->[ $file ][ $rank ];
        }

        print "\n    ├────┼────┼────┼────┼────┼────┼────┼────┤\n" if $rank > 0;
    }

    print "\n    └────┴────┴────┴────┴────┴────┴────┴────┘\n";
    print   "       a    b    c    d    e    f    g    h\n\n";
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $start, $end, $expected) = split / \| /x, $line;

        for ($test_name, $start, $end, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $moves = find_moves( $start, $end );
        my $count = scalar( @$moves ) - 1;

        is $count, $expected, $test_name;
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
Example 1 |g2|a8|4
Example 2 |g2|h2|3
Zero moves|g2|g2|0
One move  |g2|f4|1
