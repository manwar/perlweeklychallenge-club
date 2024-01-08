#!/usr/bin/env raku

use v6.d;

sub most-frequent-letter-pair(Str:D $s --> Str) {
    my $pair-bag = Bag(map({ substr($s, $_..$_+1) }, 0..$s.chars - 2));
    my Int $max-repititions = max($pair-bag.values);
    return sort(grep({ $pair-bag{$_} == $max-repititions }, $pair-bag.keys))[0];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is most-frequent-letter-pair('abcdbca'), 'bc',
        'works for "bc" in ("abcdbca")';
    is most-frequent-letter-pair('cdeabeabfcdfabgcd'), 'ab',
        'works for "ab" in ("cdeabeabfcdfabgcd")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(Str:D $s) {
    say most-frequent-letter-pair($s);
}
