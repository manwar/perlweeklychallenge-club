#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'min';

sub main (@word_array) {
    my @freq_array = ();
    my @solution   = ();

    # Turn the words into a frequency dict
    foreach my $word (@word_array) {
        my %freq = ();
        foreach my $letter ( split //, $word ) {
            $freq{$letter}++;
        }
        push @freq_array, \%freq;
    }

    # Find the minimum frequency of each character across all words
    foreach my $letter ( sort keys %{ $freq_array[0] } ) {
        my $min_freq = min( map { $_->{$letter} // 0 } @freq_array );
        if ( $min_freq > 0 ) {
         # If the minimum frequency is greater than zero, add it to the solution
            push @solution, ($letter) x $min_freq;
        }
    }

    say '(' . join( ', ', map { "\"$_\"" } @solution ) . ')';
}

main(@ARGV);
