#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@words) {
    my @words_list = map { [split / / ]} @words;
    my $count      = 0;

    # Take a list of unique words in the first list
  O: foreach my $word ( uniq( @{ $words_list[0] } ) ) {
        # Check that it occurs once in each list
        foreach my $words (@words_list) {
            my $c = grep { $_ eq $word } @$words;
            if ( $c != 1 ) {
                # It doesn't, go to the next word.
                next O;
            }
        }

        # It does, add to the count
        $count++;
    }

    # Count the number of words that appear in all lists
    say $count;
}

main(@ARGV);