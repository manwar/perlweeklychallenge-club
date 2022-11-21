#! /usr/bin/perl6

use Test;

plan 3;

is(binaryflip(5), 2, 'example 1');
is(binaryflip(4), 3, 'example 2');
is(binaryflip(6), 1, 'example 3');

sub binaryflip($n) {
    my $m = $n;
    my $r = 0;
    while ($m > 0) {
        $m +>= 1;
        $r++;
    }
    return (1 +< $r) - 1 - $n;
}
