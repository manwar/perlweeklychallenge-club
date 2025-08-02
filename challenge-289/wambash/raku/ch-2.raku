#!/usr/bin/env raku

multi jumbled-word ($word where { .chars ≤ 3 }) { $word }

multi jumbled-word ($word) {
    $word
    andthen .comb
    andthen .cache
    andthen .head, |.skip.head(*-1).pick(*), .tail
    andthen .join
}

sub jumbled-letters ($str) {
    $str.wordcase: filter => &jumbled-word
}

multi MAIN (Bool :test($)!) {
    use Test;
    is jumbled-word('Perl'), 'Perl'|'Prel';
    is jumbled-word('is'), 'is';
    is jumbled-word('a'), 'a';
    is jumbled-letters('Perl is good.'), ('Prel'|'Perl') ~' is good.';
    done-testing;
}

multi MAIN ($str) {
    say jumbled-letters $str
}
