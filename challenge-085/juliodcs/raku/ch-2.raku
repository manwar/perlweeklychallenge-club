#! /usr/bin/raku

sub power-of-ints($num where * > 0) {
    my $base := (2 .. $num div 2).first: $num %% * or return False;
    log($num, $base).round(1/10) == log($num, $base).round
}

if (@*ARGS.elems > 0) {
    say power-of-ints @*ARGS.head.Int;
    exit 0;
}

use Test;

ok !power-of-ints(1), 'Number 1';
ok  power-of-ints(4), '2^2 = 4';
ok  power-of-ints(8), 'Test case 1';
ok !power-of-ints(15), 'Test case 2';
ok  power-of-ints(125), 'Test case 3';
ok  power-of-ints(64), 'Test case 3';
ok  power-of-ints(2197), '13^3';
ok !power-of-ints(2198), '13^3 + 1';
ok !power-of-ints(2196), '13^3 - 1';
ok !power-of-ints(4394), '13^3 * 2';
ok !power-of-ints(100 ** 100), 'Big number';
ok !power-of-ints(199999), 'Big prime';
ok  power-of-ints(199999 ** 20), 'Big prime base';

done-testing;
