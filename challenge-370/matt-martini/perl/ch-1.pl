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

plan tests => 5;

sub popular_word {
    my $paragraph = $_[0]->[0];
    my @banned    = @{ $_[0]->[1] };
    printf qq{ Input: \$paragraph = "%s"\n\t\@banned = "%s"\n },
        $paragraph,
        join( '", "' => @banned );

    $paragraph = lc $paragraph;
    $paragraph =~ s/[^\s\pL]+/ /g;    # remove non-letters except spaces

    my %words;
    $words{ $_ }++ for split '\s+' => $paragraph;         # count occurrences
    delete $words{ $_ } for @banned;

    my @keys   = sort { $words{ $b } <=> $words{ $a } } keys(%words);
    my $result = $keys[0];    # sort counts and take the top one

    printf qq{Output: "%s"\n}, $result;
    return $result;
}

my @examples
    = (
        {  in =>
           [ "Bob hit a ball, the hit BALL flew far after it was hit.", ["hit"] ],
           out  => "ball",
           name => 'example 1'
        },
        {  in => [ "Apple? apple! Apple, pear, orange, pear, apple, orange.",
                   [ "apple", "pear" ]
                 ],
           out  => "orange",
           name => 'example 2'
        },
        {  in   => [ "A. a, a! A. B. b. b.", ["b"] ],
           out  => "a",
           name => 'example 3'
        },
        {  in   => [ "Ball.ball,ball:apple!apple.banana", ["ball"] ],
           out  => "apple",
           name => 'example 4'
        },
        {  in => [
                   "The dog chased the cat, but the dog was faster than the cat.",
                   [ "the", "dog" ]
                 ],
           out  => "cat",
           name => 'example 5'
        },
      );

is( popular_word( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;
