#!/usr/bin/env perl6

use Test;

is word-break("perlweeklychallenge", [ "weekly", "challenge", "perl" ]),
   [ "weekly", "challenge", "perl" ];

is word-break("perlandraku", [ "python", "ruby", "haskell" ]),
   '';

sub word-break(Str $string, @words where .all ~~ Str) {
    return @words.grep: -> $re { $string ~~ / $re / };
}
