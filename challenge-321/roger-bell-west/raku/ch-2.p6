#! /usr/bin/raku

use Test;

plan 3;

is(backspacecompare('ab#c', 'ad#c'), True, 'example 1');
is(backspacecompare('ab##', 'a#b#'), True, 'example 2');
is(backspacecompare('a#b', 'c'), False, 'example 3');

sub backspacecompare($a, $b) {
    my @sa;
    for [$a, $b] -> $i {
        my @oa;
        for $i.comb -> $c {
            if $c eq '#' {
                @oa.pop;
            } else {
                @oa.push($c);
            }
        }
        @sa.push(@oa.join(''));
    }
    @sa[0] eq @sa[1];
}
