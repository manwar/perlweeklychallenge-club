#! /usr/bin/raku

use Test;

plan 3;

is(groupdigitsum('111122333', 3), '359', 'example 1');
is(groupdigitsum('1222312', 2), '76', 'example 2');
is(groupdigitsum('100012121001', 4), '162', 'example 3');

sub groupdigitsum($a, $sz) {
    my $s = $a;
    my $n = 0;
    while (True) {
        my $t = '';
        for $s.comb.kv -> $i, $c {
            $n += $c;
            if ($i == $s.chars - 1 || ($i + 1) % $sz == 0) {
                $t ~= $n;
                $n = 0;
            }
        }
        $s = $t;
        if ($s.chars <= $sz) {
            last;
        }
    }
    $s
}
