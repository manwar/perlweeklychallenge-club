#! /usr/bin/raku

use Test;

plan 2;

is(h_index([10, 8, 5, 4, 3]), 4, 'example 1');
is(h_index([25, 8, 5, 3, 3]), 3, 'example 2');

sub h_index(@c0) {
    my @c = @c0.sort.reverse;
    my $h = 0;
    for (0..@c.end) -> $i {
        if ($i + 1 <= @c[$i]) {
            $h = $i + 1;
        } else {
            last;
        }
    }
    return $h;
}
