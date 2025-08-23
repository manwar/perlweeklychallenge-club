#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub check_winner ($board_ref) {
    my @board = @$board_ref;

    # use Data::Dumper; say Dumper(\@board); # Debugging line
    # Check rows and columns
    foreach my $i ( 0 .. 2 ) {
        if ( $board[$i][0] eq $board[$i][1] eq $board[$i][2] ne '_' ) {
            return $board[$i][0];
        }
        if ( $board[0][$i] eq $board[1][$i] eq $board[2][$i] ne '_' ) {
            return $board[0][$i];
        }
    }

    # Check diagonals
    if ( $board[0][0] eq $board[1][1] eq $board[2][2] ne '_' ) {
        return $board[0][0];
    }
    if ( $board[2][0] eq $board[1][1] eq $board[0][2] ne '_' ) {
        return $board[2][0];
    }

    return undef;
}

sub main (@ints) {
    # Turn the input into pairs of moves
    my @moves = ();
    for ( my $i = 0 ; $i < $#ints ; $i += 2 ) {
        push @moves, [ $ints[$i], $ints[ $i + 1 ] ];
    }

    # Initialize the board
    my @board = ( [ '_', '_', '_' ], [ '_', '_', '_' ], [ '_', '_', '_' ], );

    # Player A starts first
    my $current_player = 'A';

    foreach my $move (@moves) {
        # Check the move is on the board and not already taken
        if (   $move->[0] < 0
            or $move->[0] > 2
            or $move->[1] < 0
            or $move->[1] > 2 )
        {
            die "Invalid move (out of bounds)\n";
        }
        if ( $board[ $move->[0] ][ $move->[1] ] ne '_' ) {
            die "Invalid move (already taken)\n";
        }

        # Place the move on the board
        $board[ $move->[0] ][ $move->[1] ] = $current_player;

        # Check for a win
        my $result = check_winner( \@board );
        if ($result) {
            say $result;
            return;
        }

        # Switch players
        $current_player = $current_player eq 'A' ? 'B' : 'A';
    }

    # We've made all moves, check for pending or draw
    foreach my $row (@board) {
        if ( grep { $_ eq '_' } @$row ) {
            say 'Pending';
            return;
        }
    }

    say 'Draw';
}

main(@ARGV);
