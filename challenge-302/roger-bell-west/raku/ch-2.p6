#! /usr/bin/raku

use Test;

plan 3;

is(stepbystep([-3, 2, -3, 4, 2]), 5, 'example 1');
is(stepbystep([1, 2]), 1, 'example 2');
is(stepbystep([1, -2, -3]), 5, 'example 3');

sub stepbystep(@a) {
    my $mv = 0;
    my $tot = 0;
    for @a -> $s {
        $tot += $s;
        if ($mv > $tot) {
            $mv = $tot;
        }
    }
    1 - $mv;
}
