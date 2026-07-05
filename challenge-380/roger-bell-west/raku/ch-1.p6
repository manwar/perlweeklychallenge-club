#! /usr/bin/raku

use Test;

plan 5;

is(sumoffrequencies('banana'), 5, 'example 1');
is(sumoffrequencies('teestett'), 7, 'example 2');
is(sumoffrequencies('aeiouuaa'), 3, 'example 3');
is(sumoffrequencies('rhythm'), 2, 'example 4');
is(sumoffrequencies('x'), 1, 'example 5');

sub sumoffrequencies($a) {
    my $vw = 0;
    my $cn = 0;
    my %cc = $a.comb.Bag;
    my @cv = %cc.values.sort.reverse;
    for @cv -> $n {
        for %cc.kv -> $c, $ni {
            if ($ni == $n) {
                given $c {
                    when 'a' | 'e' | 'i' | 'o' | 'u' {
                        if ($vw == 0) {
                            $vw = $n;
                        }
                    }
                    default {
                        if ($cn == 0) {
                            $cn = $n;
                        }
                    }
                }
                if ($vw > 0 && $cn > 0) {
                    last;
                }
            }
        }
        if ($vw > 0 && $cn > 0) {
            last;
        }
    }
    $vw + $cn;
}
