#! /usr/bin/raku

use Test;

plan 2;

is(goodstrings(['cat', 'bt', 'hat', 'tree'], 'atach'), 6, 'example 1');
is(goodstrings(['hello', 'world', 'challenge'], 'welldonehopper'), 10, 'example 2');

sub word2map($word) {
    return Bag.new($word.lc.comb);
}

sub goodstrings(@words, $chars) {
    my $out = 0;
    my $cm = word2map($chars);
    for @words -> $w {
        my $f = word2map($w);
        my $valid = True;
        for $f.keys -> $c {
            if ($cm{$c}:!exists || $f{$c} > $cm{$c}) {
                $valid = False;
                last;
            }
        }
        if ($valid) {
            $out += $w.chars;
        }
    }
    return $out;
}

