#! /usr/bin/raku

use Test;

plan 5;

is(basen(42, 2), '101010', 'example 1');
is(basen(15642094, 16), 'EEADEE', 'example 2');
is(basen(493, 8), '755', 'example 3');
is(basen(2228519, 36), '1BRJB', 'example 4');
is(basen(123456789, 64), '7MyqL', 'example 5');

sub basen($a, $base) {
    if ($a == 0) {
        return "0";
    }
    my @digits = (
        ('0' .. '9').list,
        ('A' .. 'Z').list,
        ('a' .. 'z').list,
        '+',
        '/').flat;
    my @fields;
    my $aa = $a;
    while ($aa > 0) {
        @fields.push($aa % $base);
        $aa = $aa div $base;
    }
    my $output = '';
    while (@fields.elems > 0) {
        $output ~= @digits[@fields.pop];
    }
    $output;
}
