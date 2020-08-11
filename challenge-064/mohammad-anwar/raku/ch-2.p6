#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$string = "perlweeklychallenge",
         :@words where .all ~~ Str = ("weekly", "challenge", "perl")) {

    word-break($string, @words).join(", ").say;
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
