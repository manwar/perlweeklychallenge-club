#!/usr/bin/perl

# You are given a list of sentences.  A sentence is a list of words that are
# separated by a single space with no leading or trailing spaces.  Write a
# script to find out the maximum number of words that appear in a single
# sentence.

use 5.036;
use utf8;

use List::Util qw(max);

sub max_words (@sentences) {
    return max 0, map { scalar split } @sentences;
}

say max_words(
    'Perl and Raku belong to the same family.',
    'I love Perl.',
    'The Perl and Raku Conference.'
);

say max_words(
    'The Weekly Challenge.',
    'Kotlin is the most interesting guest language.',
    'Team PWC has over 300 members.'
);
