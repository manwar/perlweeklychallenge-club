#! /usr/bin/raku

use Test;

plan 3;

is(formatstring('ABC-D-E-F', 3), 'ABC-DEF', 'example 1');
is(formatstring('A-BC-D-E', 2), 'A-BC-DE', 'example 2');
is(formatstring('-A-B-CD-E', 4), 'A-BCDE', 'example 3');

sub formatstring($a, $n) {
    my @p = $a.comb.grep({$_ ne '-'});
    my $r = @p.elems % $n;
    if ($r == 0) {
        $r += $n;
    }
    my $o;
    for @p.kv -> $i, $c {
        if ($r == $i) {
            $o ~= '-';
            $r += $n;
        }
        $o ~= $c;
    }
    $o;
}
