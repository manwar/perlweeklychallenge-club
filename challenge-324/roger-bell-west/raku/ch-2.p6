#! /usr/bin/raku

use Test;

plan 3;

is(totalxor([1, 3]), 6, 'example 1');
is(totalxor([5, 1, 6]), 28, 'example 2');
is(totalxor([3, 4, 5, 6, 7, 8]), 480, 'example 3');

sub totalxor(@i) {
    my $tot = 0;
    for @i.combinations(1..@i.elems) -> @c {
        $tot += reduce(&infix:<+^>, @c);
    }
    $tot
}
 
