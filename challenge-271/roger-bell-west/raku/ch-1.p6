#! /usr/bin/raku

use Test;

plan 3;

is(maximumones([[0, 1], [1, 0]]), 1, 'example 1');
is(maximumones([[0, 0, 0], [1, 0, 1]]), 2, 'example 2');
is(maximumones([[0, 0], [1, 1], [0, 0]]), 2, 'example 3');

sub maximumones(@a) {
    my @ax = @a.map({$_.sum()});
    my $am = @ax.max();
    for @ax.kv -> $i, $n {
        if ($n == $am) {
            return $i + 1;
            }
    }
    return 0;
}

        
