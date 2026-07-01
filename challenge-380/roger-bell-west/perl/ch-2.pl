#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(reversedegree('z'), 1, 'example 1');
is(reversedegree('a'), 26, 'example 2');
is(reversedegree('bbc'), 147, 'example 3');
is(reversedegree('racecar'), 560, 'example 4');
is(reversedegree('zyx'), 14, 'example 5');

sub reversedegree($a) {
    my $t = 0;
    my $z0 = ord('z') + 1;
    my @ac = split '', $a;
    while (my ($i, $c) = each @ac) {
        $t += ($z0 - ord($c)) * (1 + $i);
    }
    $t;
}
