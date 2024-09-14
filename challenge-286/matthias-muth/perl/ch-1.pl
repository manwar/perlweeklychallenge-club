#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 286 Task 1: Self Spammer
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub self_spammer() {

    # 'Slurp' the whole source file, and split it into words.
    my @all_words = split " ", do { ( @ARGV, $/ ) = $0; <> };

    # Return a random word.
    return $all_words[ rand( @all_words ) ];
}


use Test2::V0 qw( -no_srand );
use List::Util qw( uniq );

# Determine all *different* words in the source file
# (very similar to how we did before...).
my @word_list = uniq split " ", do { local ( @ARGV, $/ ) = $0; <> };

# Repeatedly call the solution function to get random words,
# collecting them until we have as many different words as we know are
# contained in the file,
# or until we hit a number of calls limit
# (so that we won't loop forever if anything goes wrong).
my ( $n_calls, $max_n_calls ) = ( 0, 10000 );
my %found;
$found{ self_spammer() } = 1
    until scalar %found == scalar @word_list
        || ++$n_calls >= $max_n_calls;

note "$n_calls calls";
note "found ", scalar %found,
    " of ", scalar @word_list, " different words in file";

        is [ keys %found ],
    bag {
        item( $_ )
            for @word_list;
        end();
    },
    "all words were found at least once, and no unexpected words were found";

done_testing;
