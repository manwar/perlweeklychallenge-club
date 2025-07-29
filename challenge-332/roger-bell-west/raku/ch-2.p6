#! /usr/bin/raku

use Test;

plan 3;

is(oddletters('weekly'), False, 'example 1');
is(oddletters('perl'), True, 'example 2');
is(oddletters('challenge'), False, 'example 3');

sub oddletters($a) {
    my %c;
    $a.comb('').map({%c{$_}++});
    (%c.values.all % 2 == 1).Bool;
}
