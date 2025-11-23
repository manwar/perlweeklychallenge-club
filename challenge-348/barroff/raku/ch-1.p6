#!/usr/bin/env raku

use v6.d;

sub string-alike(Str $str --> Bool) {
    my @str-split = $str.lc.comb;
    my @p1 = grep({ @str-split[$_] ~~ /<[aeiou]>/ }, 0..^@str-split.elems div 2);
    my @p2 = grep({ @str-split[$_] ~~ /<[aeiou]>/ }, @str-split.elems div 2 ..^ @str-split.elems);
    return @p1.elems ≠ 0 && @p1.elems == @p2.elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is string-alike("textbook"), False, 'works for "textbook"';
    is string-alike("book"), True, 'works for "book"';
    is string-alike("AbCdEfGh"), True, 'works for "AbCdEfGh"';
    is string-alike("rhythmmyth"), False, 'works for "rhythmmyth"';
    is string-alike("UmpireeAudio"), False, 'works for "UmpireeAudio"';
}

#| Take user provided string like "PerlWeeklyChallenge"
multi sub MAIN(Str $str) {
    say string-alike($str);
}
