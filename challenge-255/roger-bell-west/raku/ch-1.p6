#! /usr/bin/raku

use Test;

plan 3;

is(oddcharacter('Perl', 'Preel'), 'e', 'example 1');
is(oddcharacter('Weekly', 'Weeakly'), 'a', 'example 2');
is(oddcharacter('Box', 'Boxy'), 'y', 'example 3');

sub oddcharacter($s, $t) {
    my %ss;
    map {%ss{$_}++}, $s.comb;
    for $t.comb -> $c {
        if (%ss{$c}:exists && %ss{$c} > 0) {
            %ss{$c}--;
        } else {
            return $c;
        }
    }
    return '@';
}
