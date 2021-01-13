#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply(word_break("perlweeklychallenge", [ "weekly", "challenge", "perl" ]),
          [ "perl", "weekly", "challenge" ], "match test");
is_deeply(word_break("perlandraku", [ "python", "ruby", "haskell" ]),
          [ 0 ], "no match test");

done_testing;

sub word_break {
    my ($string, $words) = @_;

    my $matched = [ grep { $string =~ /$_/i } @$words ];
    return [0] unless scalar @$matched;

    my $search_order = {};
    foreach my $word (@$matched) {
        $search_order->{index($string, $word)} = $word;
    }

    return [
        map  { $search_order->{$_} }
        sort { $a <=> $b } keys %$search_order
    ];
}
