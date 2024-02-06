#!/usr/bin/env raku

use v6.d;

sub reverse-vowels(Str:D $s --> Str:D) {
    my @vowels = grep({ $_ ~~ m:g:i/<[aeiou]>/ }, $s.comb);
    $s.subst(/:i <[aeiou]>/, { @vowels.pop()}, :g, :ii);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is reverse-vowels("Raku"), "Ruka", 'works for "Raku"';
    is reverse-vowels("Perl"), "Perl", 'works for "Perl"';
    is reverse-vowels("Julia"), "Jaliu", 'works for "Julia"';
    is reverse-vowels("Uiua"), "Auiu", 'works for "Uiua"';
}

#| Take user provided word like aba
multi sub MAIN(Str:D $s) {
    say reverse-vowels($s);
}
