#! /usr/bin/raku

use Test;

plan 3;

is(upperlower('pERL'), 'Perl', 'example 1');
is(upperlower('rakU'), 'RAKu', 'example 2');
is(upperlower('PyThOn'), 'pYtHoN', 'example 3');

sub upperlower($a) {
    my $out = '';
    for $a.comb -> $c {
        $out ~= chr(ord($c) +^ 32);
    }
    $out;
}
