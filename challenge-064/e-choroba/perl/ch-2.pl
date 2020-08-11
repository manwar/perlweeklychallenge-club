#!/usr/bin/perl
use warnings;
use strict;

sub _word_break {
    my ($string, $results, @words) = @_;
    return $results unless @words;

    for my $i (0 .. $#words) {
        my $word = $words[$i];
        next unless 0 == index $string, $word;

        my $r = _word_break(substr($string, length $word),
                            [@$results, $word],
                            @words[ grep $_ != $i, 0 .. $#words ]);
        return $r if $r;
    }
    return 0
}

sub word_break {
    my ($string, @words) = @_;
    return _word_break($string, [], @words)
}

use Test::More tests => 4;

is_deeply word_break(qw( perlweeklychallenge weekly challenge perl )),
          [qw[ perl weekly challenge ]];

is_deeply word_break(qw( perlandraku python ruby haskell )),
          0;

is_deeply word_break(qw( aabaa a ab aa )),
          [qw[ a ab aa ]];

is_deeply word_break(qw( abababa a bab aba )),
          [qw[ a bab aba ]];

