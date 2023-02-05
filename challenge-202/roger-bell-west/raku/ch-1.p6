#! /usr/bin/raku

use Test;

plan 4;

is(consecutiveodds([1, 5, 3, 6]), True, 'example 1');
is(consecutiveodds([2, 6, 3, 5]), False, 'example 2');
is(consecutiveodds([1, 2, 3, 4]), False, 'example 3');
is(consecutiveodds([2, 3, 5, 7]), True, 'example 4');

sub consecutiveodds(@a) {
    my $i = 0;
    for (@a) -> $v {
        if ($v % 2 == 1) {
            $i++;
            if ($i >= 3) {
                return True;
            }
        } else {
            $i = 0;
        }
    }
    return False;
}
