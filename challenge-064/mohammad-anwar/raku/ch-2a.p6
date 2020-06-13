#!/usr/bin/env perl6

use Test;

is word-break("perlweeklychallenge", [ "weekly", "challenge", "perl" ]),
   [ "perl", "weekly", "challenge" ],
   "match test";

is word-break("perlandraku", [ "python", "ruby", "haskell" ]),
   0,
   "no match test";

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
