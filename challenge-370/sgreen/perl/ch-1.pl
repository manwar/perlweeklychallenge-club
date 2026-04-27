#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(none max);
use List::MoreUtils 'first_value';

sub main (@args) {
    my ( $paragraph, @banned_words ) = @args;

    # Convert the paragraph and banned list to lower case
    $paragraph    = lc $paragraph;
    @banned_words = map { lc } @banned_words;

    # Count the frequency of non banned words
    my %freq = ();
    for my $word ( split /[^a-z]+/, $paragraph ) {
        if ( $word ne '' and none { $_ eq $word } @banned_words ) {
            $freq{$word}++;
        }
    }

    # Find the maximum frequency and the word that has this frequency
    my $max_freq = max( values %freq );
    my $word     = first_value { $freq{$_} == $max_freq } keys %freq;
    say $word;
}

main(@ARGV);
