#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 281 Task 2 Knight's Move
#=============================================================================
# A Knight in chess can move from its current position to any square two
# rows or columns plus one column or row away.
# Write a script which takes a starting position and an ending position
# and calculates the least number of moves required.
# Example 1 Input: $start = 'g2', $end = 'a8'
#           Ouput: 4
#   g2 -> e3 -> d5 -> c7 -> a8
# Example 2 Input: $start = 'g2', $end = 'h2'
#           Ouput: 3
#   g2 -> e3 -> f1 -> h2
#=============================================================================
#
# Screams for a breadth-first search for shortes path algorithm. Doing
# something else here.  Build a grid that shows all the possible knight moves.
# Put a 0 at 0,0.  Then, at all possible knight moves, put a 1.  For each 1,
# put a 2 at all possible knight moves from there.  Repeat until the 8x8 grid
# is filled.  Each square contains the number of knight moves that it takes
# to get there from 0,0.
# Now shift the (start,end) line so that one end of it is at the origin.
# The move count can then be read off the grid at the other end.
#
# Shifting the line to the origin might shift one end out of the grid, so
# take advantage of symmetry to reflect the line to stay inside the grid.

use v5.40;
use feature 'class'; no warnings 'experimental::class';


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

class Board
{
    field $row :param //= 8;
    field $col :param //= 8;
    field $lastRow = $row - 1;
    field $lastCol = $col - 1;

    field @board;
    ADJUST {
        # The board starts out as 8x8 undef values
        push @board, [ (undef) x $col ] for ( 1 .. $row );

        # Move a knight around the board, starting at 0,0
        $self->init();
    }

    # Debugging aid
    method show()
    {
        for my $row ( reverse 0 .. $lastRow )
        {
            print " $row: ";
            say join(" ", map { $_ // "." } $board[$row]->@*);
        }
        say "    ", join(" ", map { "-" } 0 .. $lastCol);
        say "    ", join(" ", 0 .. $lastCol);
    }

    # Generate coordinate pairs that are valid moves from the given square.
    method knightMoveFrom($r, $c)
    {
        # Stay in range of the board
        grep { 0 <= $_->[0] <= $lastRow  &&  0 <= $_->[1] <= $lastCol }
        # Add all possible knight moves to the given start
        map { [ $r + $_->[0], $c + $_->[1] ] }
            ( [-1, 2], [1,2], [-1,-2], [1,-2], [2,1], [2, -1], [-2, 1], [-2, -1 ] )
    }

    # Fill the board with the number of knight moves that it takes
    # to reach each square.
    method init()
    {
        $board[0][0] = 0;

        my $step = 0;
        while ( not $self->isFull() )
        {
            for my $r ( 0 .. $lastRow )
            {
                for my $c ( 0 .. $lastCol )
                {
                    next unless ( defined $board[$r][$c] && $board[$r][$c] == $step );
                    for my $mv ( $self->knightMoveFrom($r,$c) )
                    {
                        $board[$mv->[0]][$mv->[1]] = $step+1
                        unless defined $board[$mv->[0]][$mv->[1]];
                    }
                }
            }
            $step++;
            }

        return \@board;
    }

    method isFull()
    {
        for my $r ( reverse 0 .. $#board )
        {
            for my $c ( reverse 0 .. $board[0]->$#* )
            {
                return false if ! defined $board[$r][$c];
            }
        }
        return true;
    }

    method at($r, $c)
    {
        return $board[$r][$c];
    }
}

package main;

my $Board = Board->new();


GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say km(@ARGV);

# Convert from chess notation to grid coordinates
sub chessToGrid($chess)
{
    return ( substr($chess,1,1) - 1, ord(substr($chess, 0, 1)) - ord('a') )
}
sub km($start, $end)
{
    my @start = chessToGrid($start);
    my @end   = chessToGrid($end);

    # If the slope is negative, reflect the line so that the slope is positive. 
    my $dy = $end[1] - $start[1];
    my $dx = $end[0] - $start[0];
    my $slope = ( $dx == 0 ? 0 : $dy / $dx );
    if ( $slope < 0 )
    {
        ( $start[0], $end[0] ) = ( $end[0], $start[0] );
    }

    # If the end is below the start, swap ends
    if ( $end[0] < $start[0] || $end[1] < $start[1] )
    {
        ( $start[0], $start[1], $end[0], $end[1] ) = ( @end, @start);
    }

    # Translate the line segment so the start is at 0,0
    $end[0] -= $start[0];
    $end[1] -= $start[1];

    return $Board->at(@end);
}

sub runTest
{
    use Test2::V0;

    is( [ chessToGrid("a1") ], [0,0] );
    is( [ chessToGrid("h8") ], [7,7] );

    is( km("g2", "a8"), 4, "Example 1");
    is( km("g2", "h2"), 3, "Example 1");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
