#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub get_frequency ($word) {
    # Return a dict with the frequency of each letter
    my %freq = ();
    foreach my $letter ( split //, uc $word ) {
        if ( 'A' le $letter and $letter le 'Z' ) {
            ++$freq{$letter};
        }
    }

    return %freq;
}

sub main (@words) {
    # The last value is the plate we are matching
    my $plate      = pop(@words);
    my %plate_freq = get_frequency($plate);
    my @solution   = ();

  W: foreach my $word (@words) {
        # Calculate the frequency of letters in the current word
        my %word_freq = get_frequency($word);
        foreach my $letter ( keys %plate_freq ) {
            # Check that letters in the plate appear in the word
            if ( not exists( $word_freq{$letter} )
                or $plate_freq{$letter} > $word_freq{$letter} )
            {
                next W;
            }
        }

        push @solution, $word;
    }

    say join ', ', @solution;
}

main(@ARGV);