#! /usr/bin/raku

use Test;

plan 2;

is(reversestring(''), '', 'example 1');
is(reversestring('reverse the given string'), 'gnirts nevig eht esrever', 'example 2');

sub reversestring($a) {
    if ($a eq '') {
        return $a;
    }
    my $b = '';
    my $l = chars($a) - 1;
    my @aa = $a.comb;
    for 0 .. $l -> $i {
        $b ~= @aa[$l - $i];
    }
    $b;
}
