#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(say state);
use List::Util qw(all);
use JSON;

# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell? Here is
# the list of U.S. states abbreviations as per wikipedia
# [page](https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations). This
# challenge was proposed by team member Neil Bowers.

my @us_states = qw( AL AK AZ AR CA
    CO CT DE FL GA
    HI ID IL IN IA
    KS KY LA ME MD
    MA MI MN MS MO
    MT NE NV NH NJ
    NM NY NC ND OH
    OK OR PA RI SC
    SD TN TX UT VT
    VA WA WV WI WY );

my %us_states_to_val = map { $_ => 1 } @us_states;

my %longest_word = ( words => [], length => 0 );

# Scan the a word list
# For each word, split into an array every two characters.
# Ensure all elements are represented in the hash above.
# For those passing that test, check if they are the longest word
# possible to construct this way
# From https://github.com/dwyl/english-words
# open my $wl, "<", "$ENV{HOME}/Downloads/words_alpha.txt";
open my $wl, "<", "/usr/share/dict/words";
while ( my $w = <$wl> ) {

    # Chomp and drop apostrophes or any other
    # non-alphabetical characters
    chomp $w;
    my $w_alpha = $w;
    $w_alpha =~ s/[^[:alpha:]]//g;

    # Skip unless length is even: all US state codes are bigrams
    next unless ( length($w_alpha) % 2 == 0 );

    # Use unpack to split word into an array of bigrams
    # and use UC to make it all uppercase
    my @w_split = unpack "(a2)*", uc($w_alpha);

    # Skip if the set created from the word is not a
    # proper subset of the US state codes list.
    next unless all { exists $us_states_to_val{$_} } @w_split;

    # By now, we can be sure that the word is only
    # composed of elements in the us_states list.
    if ( length($w_alpha) > $longest_word{length} ) {
        @longest_word{qw(words length)} = ( [$w], length($w) );
    }
    elsif ( length($w_alpha) == $longest_word{length} ) {
        push $longest_word{words}->@*, $w;
    }
}

# Now just output what we found:
say "Longest word(s) constructed using USPS state codes: "
    . join( ", ", $longest_word{words}->@* )
    . "\nwith a length of $longest_word{length} alphabetical characters";