#!/usr/bin/perl
use warnings;
use strict;

sub jump_game {
    my ($N) = @_;
    my $index = 0;
    while ($index < $#$N) {
        return 0 if 0 == $N->[$index];

        $index += $N->[$index];
    }

    return $index == $#$N ? 1 : 0
}

use Test::More tests => 8;

is jump_game([1, 2, 1, 2]),    1, 'Example 1';
is jump_game([2, 1, 1, 0, 2]), 0, 'Example 2';

is jump_game([]), 0, 'Empty';
is jump_game([0]), 1, 'Single 0';
is jump_game([2]), 1, 'Sinlge X';
is jump_game([0, 1]), 0, 'Stuck';
is jump_game([1, 0]), 1, 'Direct';
is jump_game([3, 1, 1, 2, 1]), 0, 'Over';
