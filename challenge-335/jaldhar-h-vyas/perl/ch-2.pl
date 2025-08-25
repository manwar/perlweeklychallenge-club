#!/usr/bin/perl
use 5.038;
use warnings;

sub isWinner($player) {
    return grep { $_ == $player } (33, 303, 3003, 1110, 1113, 1116);
}

my (@moves) = @ARGV;
my $A = 0;
my $B = 0;
my $result = 'Pending';

for my $turn (keys @moves) {
    my ($row, $col) = split q{,}, $moves[$turn];

    if ($turn % 2) {
        $B += 10 ** ($row + 1) + $col;
        if (isWinner($B)) {
            $result = 'B';
            last;
        }
    }

    else {
        $A += 10 ** ($row + 1) + $col;
        if (isWinner($A)) {
            $result = 'A';
            last;
        }
    }

    if ($turn == 8) {
        $result = 'Draw';
        last;
    }
}

say $result;
