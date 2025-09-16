#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ch-2.pl - The Weekly Challenge 335 Task 2: Find Winner

=head1 DESCRIPTION

Given a sequence of tic-tac-toe moves played on a 3x3 grid (starting with
player A and alternating), determine the game outcome. A win occurs when either
player claims an entire row, column, or diagonal. If both players complete all
moves without a winner, the result is a Draw; otherwise, the game is Pending.

=head1 AUTHOR

Lubos Kolouch

=cut

use List::Util qw(any);
use Test::More tests => 5;

use constant MoveList => 'ARRAY';

sub find_winner {
    my (@moves) = @_;

    my @board  = map { [ ('_') x 3 ] } 1 .. 3;
    my $player = 'A';
    for my $move (@moves) {
        my ( $row, $col ) = @$move;
        $board[$row][$col] = $player;
        $player = $player eq 'A' ? 'B' : 'A';
    }

    my $winner = _check_winner( \@board );
    return $winner if $winner;

    return @moves == 9 ? 'Draw' : 'Pending';
}

sub _check_winner {
    my ($board) = @_;

    my @lines;
    push @lines, $board->[$_] for 0 .. 2;
    push @lines, [ map { $board->[$_][0] } 0 .. 2 ];
    push @lines, [ map { $board->[$_][1] } 0 .. 2 ];
    push @lines, [ map { $board->[$_][2] } 0 .. 2 ];
    push @lines, [ map { $board->[$_][$_] } 0 .. 2 ];
    push @lines, [ map { $board->[$_][ 2 - $_ ] } 0 .. 2 ];

    for my $line (@lines) {
        return $line->[0] if $line->[0] ne '_' && $line->[0] eq $line->[1] && $line->[1] eq $line->[2];
    }
    return '';
}

subtest 'Example 1' => sub {
    my @moves = ( [ 0, 0 ], [ 2, 0 ], [ 1, 1 ], [ 2, 1 ], [ 2, 2 ] );
    is( find_winner(@moves), 'A', 'Player A wins' );
};

subtest 'Example 2' => sub {
    my @moves = ( [ 0, 0 ], [ 1, 1 ], [ 0, 1 ], [ 0, 2 ], [ 1, 0 ], [ 2, 0 ] );
    is( find_winner(@moves), 'B', 'Player B wins' );
};

subtest 'Example 3' => sub {
    my @moves = ( [ 0, 0 ], [ 1, 1 ], [ 2, 0 ], [ 1, 0 ], [ 1, 2 ], [ 2, 1 ], [ 0, 1 ], [ 0, 2 ], [ 2, 2 ] );
    is( find_winner(@moves), 'Draw', 'Game ends in draw' );
};

subtest 'Example 4' => sub {
    my @moves = ( [ 0, 0 ], [ 1, 1 ] );
    is( find_winner(@moves), 'Pending', 'Game still pending' );
};

subtest 'Example 5' => sub {
    my @moves = ( [ 1, 1 ], [ 0, 0 ], [ 2, 2 ], [ 0, 1 ], [ 1, 0 ], [ 0, 2 ] );
    is( find_winner(@moves), 'B', 'Player B wins with top row' );
};
