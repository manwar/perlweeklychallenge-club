#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply(word_break("perlweeklychallenge", [ "weekly", "challenge", "perl" ]),
          [ "weekly", "challenge", "perl" ]);
is_deeply(word_break("perlandraku", [ "python", "ruby", "haskell" ]),
          [ ]);

done_testing;

sub word_break {
    my ($string, $words) = @_;

    return [ grep { $string =~ /$_.*?/i } @$words ];
}
