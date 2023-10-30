#!/usr/bin/env raku

use v6.d;

sub acronym(Str:D $chk, *@str --> Bool) {
    $chk.lc eq [~] map({ substr($_.lc, 0..0) }, @str)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is acronym("ppp", ("Perl", "Python", "Pascal")), True,
        'works for "ppp" and ("Perl", "Python", "Pascal")';
    is acronym("rp", ("Perl", "Raku")), False,
        'works for "rp" and ("Perl", "Raku")';
    is acronym("oac", ("Oracle", "Awk", "C")), True,
        'works for "oac" and ("Oracle", "Awk", "C")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(Str:D $chk, *@words where @words.elems ≥ 1) {
    say acronym(@words);
}
