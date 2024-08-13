#! /usr/bin/raku

use Test;

plan 3;

is(changingkeys('pPeERrLl'), 3, 'example 1');
is(changingkeys('rRr'), 0, 'example 2');
is(changingkeys('GoO'), 1, 'example 3');

sub changingkeys($a) {
    my $oc = 'x';
    my $out = 0;
    for $a.lc.comb.kv -> $i, $c {
        if ($i == 0) {
            $oc = $c;
        } elsif ($c ne $oc) {
            $oc = $c;
            $out++;
        }
    }
    return $out;
}
