#!/usr/bin/raku

sub isWinner($player) {
    return (33, 303, 3003, 1110, 1113, 1116).grep($player).so;
}

sub MAIN(
    *@moves
) {
    my $A = 0;
    my $B = 0;
    my $result = 'Pending';

    for @moves.kv -> $turn, $square {
        my ($row, $col) = $square.split(q{,})».Int;

        if $turn %% 2 {
            $A += 10 ** ($row + 1) + $col;
            if isWinner($A) {
                $result = 'A';
                last;
            }
        }

        else {
            $B += 10 ** ($row + 1) + $col;
            if isWinner($B) {
                $result = 'B';
                last;
            }
        }

        if $turn == 8 {
            $result = 'Draw';
            last;
        }
    }

    say $result;
}