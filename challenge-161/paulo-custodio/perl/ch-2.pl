#!/usr/bin/env perl

# Challenge 161
#
# Task 2: Pangrams
# Submitted by: Ryan J Thompson
# A pangram is a sentence or phrase that uses every letter in the English
# alphabet at least once. For example, perhaps the most well known pangram is:
#
# the quick brown fox jumps over the lazy dog
# Using the provided dictionary, so that you don’t need to include individual
# copy, generate at least one pangram.
#
# Your pangram does not have to be a syntactically valid English sentence (doing
# so would require far more work, and a dictionary of nouns, verbs, adjectives,
# adverbs, and conjunctions). Also note that repeated letters, and even repeated
# words, are permitted.
#
# BONUS: Constrain or optimize for something interesting (completely up to you),
# such as:
# Shortest possible pangram (difficult)
# Pangram which contains only abecedarian words (see challenge 1)
# Pangram such that each word "solves" exactly one new letter. For example, such
# a pangram might begin with (newly solved letters in bold):
#     a ah hi hid die ice tea ...
#     What is the longest possible anagram generated with this method? (All
# solutions will contain 26 words, so focus on the letter count.)
# Pangrams that have the weirdest (PG-13) Google image search results
# Anything interesting goes!

use Modern::Perl;

chomp(my @dict = grep {/^[a-z]+$/} <>);
my %pending; for ('a' .. 'z') { $pending{$_}=1; }

my @words;
while (keys %pending) {
    my $word = next_word(\%pending);
    push @words, $word;
    for (split //, $word) { delete $pending{$_}; }
}
say "@words";

sub next_word {
    my($pending) = @_;

    my $max_word;
    my $max_letters = 0;
    for my $word (@dict) {
        # get new letters
        my %letters;
        for (split //, $word) {
            if ($pending->{$_}) {
                $letters{$_}=1;
            }
        }
        # save max letters
        my $letters = scalar(keys %letters);
        if ($letters > $max_letters) {
            ($max_word, $max_letters) = ($word, $letters);
        }
    }

    return $max_word;
}
