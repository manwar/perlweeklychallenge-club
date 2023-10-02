#! /usr/bin/raku

use Test;

plan 3;

is(specialnotes('abc', 'xyz'), False, 'example 1');
is(specialnotes('scriptinglanguage', 'perl'), True, 'example 2');
is(specialnotes('aabbcc', 'abc'), True, 'example 3');

sub word2map($word) {
    return Bag.new($word.lc.comb);
}

sub specialnotes($chars, $word) {
    my $cm = word2map($chars);
    my $f = word2map($word);
    my $valid = True;
    for $f.keys -> $c {
        if ($cm{$c}:!exists || $f{$c} > $cm{$c}) {
            $valid = False;
            last;
        }
    }
    return $valid;
}

