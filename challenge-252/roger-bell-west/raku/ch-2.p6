#! /usr/bin/raku

use Test;

plan 3;

is-deeply(uniquesumzero(5), [1, 2, 3, 4, -10], 'example 1');
is-deeply(uniquesumzero(3), [1, 2, -3], 'example 2');
is-deeply(uniquesumzero(1), [0], 'example 3');

sub uniquesumzero($n) {
    if ($n == 1) {
        return [0];
    }
    my @p = [1 .. $n - 1];
    @p.push(-$n * ($n - 1) div 2);
    return @p;
}
