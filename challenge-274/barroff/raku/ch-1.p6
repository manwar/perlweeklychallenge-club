#!/usr/bin/env raku

use v6.d;

sub goat-latin(Str $str --> Str) {
    my $vowels = Set(['a', 'e', 'i', 'o', 'u']);
    my $as = "";
    my &goat = sub ($word) {
        $as = $as ~ 'a';
        my $result = $word.comb[0] ∈ $vowels ?? $word !! rotate($word.comb, 1).join;
        $result ~ 'ma' ~ $as;
    }
    map({ &goat($_) }, words($str)).join(' ');
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is goat-latin("I love Perl"), "Imaa ovelmaaa erlPmaaaa",
        'works for "I love Perl"';
    is goat-latin("Perl and Raku are friends"),
        "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
        'works for "Perl and Raku are friends"';
    is goat-latin("The Weekly Challenge"), "heTmaa eeklyWmaaa hallengeCmaaaa",
        'works for "The Weekly Challenge"';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Str $str) {
    say goat-latin($str);
}
