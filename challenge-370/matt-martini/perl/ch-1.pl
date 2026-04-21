#!/usr/bin/env perl

# You are given a string paragraph and an array of the banned words.

# Write a script to return the most popular word that is not banned. It is
# guaranteed there is at least one word that is not banned and the answer
# is unique. The words in paragraph are case-insensitive and the answer
# should be in lowercase. The words can not contain punctuation symbols.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use JSON::MaybeXS qw (decode_json);

plan tests => 5;

sub popular_word {
    my $paragraph = $_[0]->[0];
    my @banned    = @{ $_[0]->[1] };
    printf qq{ Input: \$paragraph = "%s"\n\t\@banned = "%s"\n },
        $paragraph,
        join( '", "' => @banned );

    my %words;
    $words{ $_ }++ for split '[^a-z]+', lc $paragraph;    # count occurrences
    delete $words{ $_ } for @banned;

    my @keys   = sort { $words{ $b } <=> $words{ $a } } keys(%words);
    my $result = $keys[0];    # sort counts and take the top one

    printf qq{Output: "%s"\n}, $result;
    return $result;
}

my $examples_ref = decode_json(<DATA>);
is( popular_word( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };

__DATA__
[ { "name": "example 1", "in": [ "Bob hit a ball, the hit BALL flew far after it was hit.", [ "hit" ] ], "out": "ball" }, { "out": "orange", "name": "example 2", "in": [ "Apple? apple! Apple, pear, orange, pear, apple, orange.", [ "apple", "pear" ] ] }, { "out": "a", "name": "example 3", "in": [ "A. a, a! A. B. b. b.", [ "b" ] ] }, { "out": "apple", "in": [ "Ball.ball,ball:apple!apple.banana", [ "ball" ] ], "name": "example 4" }, { "out": "cat", "name": "example 5", "in": [ "The dog chased the cat, but the dog was faster than the cat.", [ "the", "dog" ] ] } ]
