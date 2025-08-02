#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub sort_word($word) {
    return join( '', sort split( //, lc($word) ) );
}

sub main (@words) {
    # Sort each word alphabetically, ignoring case
    my @sorted_words = map { sort_word($_) } @words;
    my $anagrams     = 0;

    foreach my $idx ( 1 .. $#words ) {
        if ( $sorted_words[ $idx - 1 ] eq $sorted_words[$idx] ) {
            # The word at this position is an anagram of the previous word
            $anagrams++;
        }
    }

    # Return the number of words that aren't an anagram
    say scalar(@words) - $anagrams;
}

main(@ARGV);
