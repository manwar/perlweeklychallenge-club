#! /usr/bin/raku

use Test;

plan 3;

is-deeply(funsort([1, 2, 3, 4, 5, 6]), [2, 4, 6, 1, 3, 5], 'example 1');
is-deeply(funsort([1, 2]), [2, 1], 'example 2');
is-deeply(funsort([1]), [1], 'example 3');

sub funsort(@l0) {
    my %h = classify { $_ %% 2 ?? 'even' !! 'odd' }, @l0.sort();
    my @a;
    for ("even", "odd") -> $mode {
        if (%h{$mode}) {
            @a.append(%h{$mode}.List);
        }
    }
    return @a;
}
