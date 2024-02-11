#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(first max);

sub main ($p, $b) {
    # Find the most frequent word that isn't banned

    # Calculate the frequency of all the words
    my %freq = ();
    foreach my $word ($p =~ /\w+(?:'\w+)?/g) {
        $freq{lc $word}++;
    }

    # Remove the bad word (if it exists)
    delete $freq{lc $b};

    # Find the maximum occurrence of any word, and the word that has this
    my $max_count = max(values(%freq));
    say first { $freq{$_} == $max_count } keys %freq;
}

main($ARGV[0], $ARGV[1]);