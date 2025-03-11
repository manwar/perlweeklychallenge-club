#! /usr/bin/raku

use Test;

plan 3;

is(minimumtime('abc'), 5, 'example 1');
is(minimumtime('bza'), 7, 'example 2');
is(minimumtime('zjpc'), 34, 'example 3');

sub transfer($a, $b) {
    my $ac = $a.ord;
    my $bc = $b.ord;
    min(($ac - $bc + 26) % 26, ($bc - $ac + 26) % 26);
}

sub minimumtime($a) {
    my $tot = $a.chars;
    my $prev = 'a';
    for $a.comb -> $c {
        $tot += transfer($prev, $c);
        $prev = $c;
    }
    $tot;
}
