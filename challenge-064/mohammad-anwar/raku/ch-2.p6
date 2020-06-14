#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$string = "perlweeklychallenge",
         :@words where .all ~~ Str = ("weekly", "challenge", "perl")) {

    my @matched = word-break($string, @words);

    (@matched.elems)
    ??
    (@matched.join(", ").say)
    !!
    (say "None matched.");
}

sub word-break(Str $string, @words where .all ~~ Str) {

    my @matched = @words.grep: -> $word { $string ~~ / $word / };
    return 0 unless @matched.elems;

    my %search-order = @matched.map(
        -> $word { $string.index($word) => $word });

    return [
        %search-order.keys.sort({ $^a <=> $^b })
        .map({ %search-order{$_} })
    ];
}
