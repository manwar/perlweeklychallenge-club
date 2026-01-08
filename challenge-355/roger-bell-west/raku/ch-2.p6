#! /usr/bin/raku

use Test;

plan 5;

is(mountainarray([1, 2, 3, 4, 5]), False, 'example 1');
is(mountainarray([0, 2, 4, 6, 4, 2, 0]), True, 'example 2');
is(mountainarray([5, 4, 3, 2, 1]), False, 'example 3');
is(mountainarray([1, 3, 5, 5, 4, 2]), False, 'example 4');
is(mountainarray([1, 3, 2]), True, 'example 5');

sub mountainarray(@a) {
    my $state = 0;
    for @a.rotor(2 => -1) -> @b {
        if (@b[1] > @b[0]) {
            if ($state == 0 || $state == 1) {
                $state = 1;
            } else {
                return False;
            }
        } elsif (@b[1] < @b[0]) {
            if ($state == 1 || $state == 2) {
                $state = 2;
            } else {
                return False;
            }
        } else {
            return False;
        }
    }
    $state == 2
}
