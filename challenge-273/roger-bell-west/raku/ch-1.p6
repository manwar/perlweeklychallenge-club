#! /usr/bin/raku

use Test;

plan 6;

is(percentageofcharacter('perl', 'e'), 25, 'example 1');
is(percentageofcharacter('java', 'a'), 50, 'example 2');
is(percentageofcharacter('python', 'm'), 0, 'example 3');
is(percentageofcharacter('ada', 'a'), 67, 'example 4');
is(percentageofcharacter('ballerina', 'l'), 22, 'example 5');
is(percentageofcharacter('analitik', 'k'), 13, 'example 6');

sub percentageofcharacter($a, $c) {
    my $d = $a.chars;
    my $n = 100 * $a.match($c, :exhaustive).elems;
    return ($n + $d div 2) div $d;
}
