#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    # Define the regular expression that makes up a single line on a keyboard
    my $r = '^(?:[qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$';

    # Find all words that match the pattern, and print it
    my @matched_words = grep { m{$r}i } @words;
    say '(', join( ',', map { qq{"$_"} } @matched_words ), ')';
}

main(@ARGV);