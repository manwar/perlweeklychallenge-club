#!/usr/bin/env perl

use v5.30;
use warnings;

use experimental 'signatures';

use List::Util 'max', 'min';

sub position_value ($n) {
    if ($n == 0) {
        return -1;
    }

    my @move_values;
    for my $move (1 .. min(3, $n)) {
        $move_values[$move] = - position_value($n - $move);
    }

    return max(grep defined, @move_values);
}

sub best_move ($n) {
    my $pos_value = position_value($n);
    my @best_moves = grep position_value($n - $_) == - $pos_value, (1 .. min(3, $n));
    return $best_moves[int rand @best_moves];
}

my $num_sticks = 12;

print "Who plays first? You or computer? (y/c): ";
chomp(my $player = <STDIN>);

while ($num_sticks > 0) {
    say "$num_sticks sticks remain.";
    my $num_pick;
    if ($player eq 'c') {
        $num_pick = best_move($num_sticks);
        say "I pick $num_pick.";
    } else {
        print "How many do you pick? ";
        chomp($num_pick = <STDIN>);
    }
    $num_sticks -= $num_pick;
    $player = $player eq 'c' ? 'y' : 'c';
}

if ($player eq 'y') {
    say "Computer wins!";
} else {
    say "You win";
}
