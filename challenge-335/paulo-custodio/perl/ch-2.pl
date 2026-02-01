#!/usr/bin/env perl

use Modern::Perl;

my @moves;
while (<>) {
    push @moves, [split ' ', $_];
}
say play_game(@moves);

sub play_game {
    my(@moves) = @_;
    my @board = ([qw(_ _ _)], [qw(_ _ _)], [qw(_ _ _)]);
    while (@moves) {
        for my $player (qw(A B)) {
            return "Pending" if !@moves;
            my($x, $y) = @{shift @moves};
            die "invalid move [$x,$y]" if $board[$x][$y] ne "_";
            $board[$x][$y] = $player;
            #print_board(@board);
            return $player if player_wins($player, @board);
            return "Draw" if board_full(@board);
        }
    }
    return "Pending";
}

sub player_wins {
    my($player, @board) = @_;
    for my $x (0,1,2) {
        return 1 if $board[$x][0] eq $player &&
                    $board[$x][1] eq $player &&
                    $board[$x][2] eq $player;
    }
    for my $y (0,1,2) {
        return 1 if $board[0][$y] eq $player &&
                    $board[1][$y] eq $player &&
                    $board[2][$y] eq $player;
    }
    return 1 if $board[0][0] eq $player &&
                $board[1][1] eq $player &&
                $board[2][2] eq $player;
    return 1 if $board[0][2] eq $player &&
                $board[1][1] eq $player &&
                $board[2][0] eq $player;
    return 0;
}

sub board_full {
    my(@board) = @_;
    for my $x (0,1,2) {
        for my $y (0,1,2) {
            return 0 if $board[$x][$y] eq "_";
        }
    }
    return 1;
}

sub print_board {
    my(@board) = @_;
    for my $x (0,1,2) {
        print "[ ";
        for my $y (0,1,2) {
            print $board[$x][$y]." ";
        }
        print "]\n";
    }
    print "\n";
}
