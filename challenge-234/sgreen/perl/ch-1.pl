#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@words) {
    # Turn the letter of the first word into a hash (key is each letter)
    my $first_word = shift @words;
    my %solution   = map { $_ => 1 } split //, $first_word;

    foreach my $word (@words) {
        foreach my $letter ( keys %solution ) {
            # If the letter is not in the current word, delete it
            if ( index( $word, $letter ) == -1 ) {
                delete $solution{$letter};
            }
        }
    }

    print join ', ', sort keys %solution;

}

main(@ARGV);