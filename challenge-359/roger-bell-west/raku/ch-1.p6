#! /usr/bin/raku

use Test;

plan 5;

is-deeply(digitalroot(38), [2, 2], 'example 1');
is-deeply(digitalroot(7), [0, 7], 'example 2');
is-deeply(digitalroot(999), [2, 9], 'example 3');
is-deeply(digitalroot(1999999999), [3, 1], 'example 4');
is-deeply(digitalroot(101010), [1, 3], 'example 5');

sub digitalroot($a) {
    my $count = 0;
    my $value = $a;
    while ($value > 9) {
        my $p = 0;
        while ($value > 0) {
            $p += $value % 10;
            $value = floor($value / 10);
        }
        $value = $p;
        $count++;
    }
    [$count, $value];
}
