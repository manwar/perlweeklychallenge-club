#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# Task 2: Pangrams
# Submitted by: Ryan J Thompson
#
# A pangram is a sentence or phrase that uses every letter in the English
# alphabet at least once. For example, perhaps the most well known pangram is:
#
# the quick brown fox jumps over the lazy dog
#
# Using the provided dictionary, so that you don’t need to include individual
# copy, generate at least one pangram.
#
# Your pangram does not have to be a syntactically valid English sentence (doing
# so would require far more work, and a dictionary of nouns, verbs, adjectives,
# adverbs, and conjunctions). Also note that repeated letters, and even repeated
# words, are permitted.

# BONUS: Constrain or optimize for something interesting (completely up to you),
# such as:
#
# * Shortest possible pangram (difficult)
# * Pangram which contains only abecedarian words (see challenge 1)
# * Pangram such that each word "solves" exactly one new letter. For example,
#   such a pangram might begin with (newly solved letters in bold):
#     a ah hi hid die ice tea ...
# * What is the longest possible pangram generated with this method? (All
#   solutions will contain 26 words, so focus on the letter count.)
# * Pangrams that have the weirdest (PG-13) Google image search results
# Anything interesting goes!

use FindBin    ();
use File::Spec ();
use List::Util qw(any max);

use lib $FindBin::RealBin;

use DictReader qw(read_dict);
use My::List::Util qw(group_by);

package challenge1 {
    ## we want to reuse `is_abecedarian` from challenge 1

    BEGIN {
        require File::Spec->catfile( $FindBin::Bin, 'ch-1.pl' );
    }
}

run() unless caller();

sub run() {
    my @dict = read_dict();

    say find_pangram_naive(@dict);
    say find_pangram_most_new_chars_used(@dict);

    my @abecedarian = grep ( challenge1::is_abecedarian($_), @dict );

    say find_pangram_naive(@abecedarian);
    say find_pangram_most_new_chars_used(@abecedarian);
}

sub find_pangram_naive(@dict) {
    ## Walks the dict in order. As soon as we  encounter a word with unused
    ## chars it is added to the pangram.

    my @unused = 'a' .. 'z';
    my @pangram;
    for my $word (@dict) {
        my @new_chars = grep { contains( $word, $_ ) } @unused;
        push @pangram, $word if @new_chars;
        @unused = without( \@unused, \@new_chars );
        if ( !@unused ) {
            return join( " ", @pangram );
        }
    }

    die "No pangram found";
}

sub find_pangram_most_new_chars_used(@dict) {
    ## In every step we find words with the most unused characters and add the
    ## shorted to the pangram.

    my @unused = 'a' .. 'z';

    my @pangram;
    while (@unused) {
        my $cur = find_word_with_most_unused_chars( \@dict, \@unused );
        @unused = without( \@unused, [ explode($cur) ] );
        push @pangram, $cur;
    }

    return join( " ", @pangram );
}

sub find_word_with_most_unused_chars ( $dict, $unused ) {
    my $words_by_unused = group_by(
        sub ($word) {
            scalar grep { contains( $word, $_ ) } @$unused;
        },
        @$dict
    );

    my $shortest = ( sort { length $a <=> length $b }
          @{ $words_by_unused->{ max( keys %$words_by_unused ) } } )[0];

    return $shortest;
}

sub contains ( $word, $char ) {
    return $word =~ m/\Q$char\E/;
}

sub without ( $as, $bs ) {
    grep {
        my $a = $_;
        !any { $_ eq $a } @$bs
    } @$as;
}

sub explode($str) {
    split( m//, $str );
}
