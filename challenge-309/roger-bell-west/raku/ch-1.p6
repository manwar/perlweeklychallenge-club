#! /usr/bin/raku

use Test;

plan 3;

is(mingap([2, 8, 10, 11, 15]), 11, 'example 1');
is(mingap([1, 5, 6, 7, 14]), 6, 'example 2');
is(mingap([8, 20, 25, 28]), 28, 'example 3');

sub mingap(@a) {
    my $mg = @a[*-1] - @a[0];
    my $mv = 0;
    for @a.rotor(2 => -1) -> @p {
        my $delta = @p[1] - @p[0];
        if ($delta < $mg) {
            $mg = $delta;
            $mv = @p[1];
        }
    }
    $mv;
}
