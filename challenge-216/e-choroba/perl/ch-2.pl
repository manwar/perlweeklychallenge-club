#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub word_stickers($word, @stickers) {
    my $chars = join "", @stickers;
    return 0 if $word =~ /[^$chars]/;

    return word_stickers_($word, \@stickers)
}

sub word_stickers_($word, $stickers, @partial) {
    return scalar @partial if "" eq $word;

    my @counts;

    for my $length (1 .. length $word) {
        my $part = substr $word, 0, $length;
        my @usables = grep -1 != index($partial[$_], $part), 0 .. $#partial;
        for my $partial_idx (@usables) {
            my $usable = $partial[$partial_idx];
            my $from = index $usable, $part;
            push @counts, word_stickers_(
                substr($word, $length),
                $stickers,
                @partial[grep $_ != $partial_idx, 0 .. $#partial],
                $usable =~ s/$part//r
            );
        }

        for my $sticker (@$stickers) {
            if (-1 != index $sticker, $part) {
                push @counts, word_stickers_(substr($word, $length),
                                             $stickers,
                                             @partial,
                                             $sticker =~ s/$part//r);
            }
        }
    }
    return min(@counts)
}

# Speed up: 2.5s -> 1s.
use Memoize qw{ memoize };
memoize('word_stickers_');


use Test::More tests => 4 + 1;
is word_stickers(peon => qw( perl raku python )), 2, 'Example 1';
is word_stickers(goat => qw( love hate angry )), 3, 'Example 2';
is word_stickers(accommodation => qw( come nation delta )), 4, 'Example 3';
is word_stickers(accommodation => qw( come country delta )), 0, 'Example 4';

is word_stickers(aabbbccc => qw( ab bc )), 5, 'a- ab -b bc c c';
