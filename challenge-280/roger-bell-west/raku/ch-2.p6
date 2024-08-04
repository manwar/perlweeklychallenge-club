#! /usr/bin/raku

use Test;

plan 3;

is(countasterisks('p|*e*rl|w**e|*ekly|'), 2, 'example 1');
is(countasterisks('perl'), 0, 'example 2');
is(countasterisks('th|ewe|e**|k|l***ych|alleng|e'), 5, 'example 3');

sub countasterisks($a) {
    my $out = 0;
    my $active = True;
    for $a.comb -> $c {
        given $c {
            when '|' {
                $active = !$active;
            }
            when '*' {
                if ($active) {
                    $out++;
                }
            }
        }
    }
    $out;
}
