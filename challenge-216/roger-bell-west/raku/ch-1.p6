#! /usr/bin/raku

use Test;

plan 3;

is-deeply(registrationnumber(['abc', 'abcd', 'bcd'], 'AB1 2CD'), ['abcd'], 'example 1');
is-deeply(registrationnumber(['job', 'james', 'bjorg'], '007 JB'), ['job', 'bjorg'], 'example 2');
is-deeply(registrationnumber(['crack', 'road', 'rac'], 'C7 RA2'), ['crack', 'rac'], 'example 3');


sub word2set($word) {
  return SetHash($word.lc.comb.grep(/<[a..z]>/));
}

sub registrationnumber(@words, $reg) {
    my $s = word2set($reg);
    my @out;
    for @words -> $w {
        my $ss = $s.clone;
        for word2set($w).keys -> $char {
            if ($ss{$char}:exists) {
                $ss.unset($char);
                if ($ss.elems == 0) {
                    @out.push($w);
                    last;
                }
            }
        }
    }
    return @out;
}
