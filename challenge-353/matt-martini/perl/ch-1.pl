#!/usr/bin/env perl

# You are given an array of sentences.

# Write a script to return the maximum number of words that appear in a single sentence.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub max_words {
    my (@sentences) = @_;
    diag 'Input: @sentences = (' . join( ', ', @sentences ) . ")\n";

    my $max_count = 0;

    MATCH:
    for my $i ( 0 .. $#sentences ) {
        my $word_count = scalar( split( ' ', $sentences[$i] ) );
        if ( $word_count > $max_count ) {
            $max_count = $word_count;
        }
    }

    diag 'Output: ' . $max_count . "\n";
    return $max_count;
}

is( max_words( ( "Hello world", "This is a test", "Perl is great" ) ),
    4, 'example 1' );
is( max_words( ("Single") ), 1, 'example 2' );
is(
    max_words(
                   (
                     "Short", "This sentence has seven words in total",
                     "A B C", "Just four words here"
                   )
             ),
    7,
    'example 3'
  );
is( max_words( ( "One", "Two parts", "Three part phrase", "" ) ),
    3, 'example 4' );
is(
    max_words(
                   (
                     "The quick brown fox jumps over the lazy dog",
                     "A",
                     "She sells seashells by the seashore",
                     "To be or not to be that is the question"
                   )
             ),
    10,
    'example 5'
  );
