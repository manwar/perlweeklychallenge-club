#! /usr/bin/raku

use Test;

plan 2;

is(pennypiles(5), 7, 'example 1');
is(pennypiles(10), 42, 'example 2');

sub pennypiles($n) {
    if ($n == 0) {
        return 1;
    }
    my $s = 0;
    my $j = $n - 1;
    my $k = 2;
    while ($j >= 0) {
        my $t = pennypiles($j);
        if (($k div 2) % 2 == 1) {
            $s += $t;
        } else {
            $s -= $t;
        }
        if ($k % 2 == 1) {
            $j -= $k;
        } else {
            $j -= ($k div 2);
        }
        $k++;
    }
    return $s;
}
