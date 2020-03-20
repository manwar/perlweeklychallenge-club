#!/usr/bin/env perl6

use v6.c;

sub MAIN() {
    # Setup coins with description
    my %coins =
        100 => "£1", 50 => "50p",   1 => "1p", 10 => "10p",
          5 => "5p", 20 => "20p", 200 => "£2",  2 => "2p"
    ;

    # Arrange coins on the table
    my @table = ();
    for %coins.keys -> $c {
        push @table, $c;
    }
    @table = @table.pick(@table);

    # Setup players for the game
    my %players =
        0 => { "name" => "Human",   "bank" => 0, "coins" => [] },
        1 => { "name" => "Machine", "bank" => 0, "coins" => [] },
    ;

    # Pick random player 0 or 1.
    # DISCLAIMER:
    # E. Choroba found out the player who picks the coin
    # first is always the winner.
    my Int $current = (^2).pick;

    # Play the game now
    my $coin;
    while @table.elems {
        if @table[0] > @table[*-1] {
            $coin = @table.shift;
        }
        else {
            $coin = @table.pop;
        }

        %players{$current}<"bank"> += $coin;
        %players{$current}<"coins">.append(%coins{$coin});

        $current = ($current)??(0)!!(1);
    }

    declare-lucky-winner(%players);
    show-coins(%players);
}

sub declare-lucky-winner(%players) {
    if %players<0><"bank"> > %players<1><"bank"> {
        say "The lucky winner is " ~ %players<0><name> ~ ".";
    }
    else {
        say "The lucky winner is " ~ %players<1><name> ~ ".";
    }
}

sub show-coins(%players) {
    for 0..1 -> $player {
        say %players{$player}<name> ~ " picked coins " ~
            @(%players{$player}<"coins">).join(", ") ~ ".";
    }
}
