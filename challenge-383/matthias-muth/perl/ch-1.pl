#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 383 Task 1: Similar List
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

use List::Util qw( mesh );

sub similar_list( $list1, $list2, $list3 ) {
    # Build a thesaurus for similar words.
    my %thesaurus = map {
        my %similarity_class = map { ( $_ => 1 ) } $_->@*;
        map { ( $_ => \%similarity_class ) } $_->@*;
    } $list3->@*;

    # Now check whether all words in the two lists are the same or similar.
    for my ( $word1, $word2 ) ( mesh $list1, $list2 ) {
        return false
            unless $word1 eq $word2
              || $thesaurus{ $word1 }{ $word2 };
    }
    return true;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1",
        [
          ["great", "acting"],
          ["fine", "drama"],
          [["great", "fine"], ["acting", "drama"]],
        ],
        T ],
    [ "Example 2",
        [
          ["apple", "pie"],
          ["banana", "pie"],
          [["apple", "peach"], ["peach", "banana"]],
        ],
        F ],
    [ "Example 3",
        [
          ["perl4", "python"],
          ["raku", "python"],
          [["perl4", "perl5", "raku"]],
        ],
        T ],
    [ "Example 4",
        [
          ["enjoy", "challenge"],
          ["love", "weekly", "challenge"],
          [["enjoy", "love"]],
        ],
        F ],
    [ "Example 5",
        [
          ["fast", "car"],
          ["quick", "vehicle"],
          [["quick", "fast"], ["vehicle", "car"]],
        ],
        T ],
);

is similar_list( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
