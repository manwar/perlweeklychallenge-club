#!/usr/bin/env perl
use strict;
use warnings;

# This is mostly written with Github Copilot. It's not the best quality code, but I wanted to give it a try. It has also helped writing this paragraph.

# As an old systems programmer, whenever I needed to come up with a 32-bit number, I would reach for the tired old examples like 0xDeadBeef and 0xC0dedBad. I want more!
# Write a program that will read from a dictionary and find 2- to 8-letter words that can be “spelled” in hexadecimal, with the addition of the following letter substitutions:
# o ⟶ 0 (e.g., 0xf00d = “food”)
# l ⟶ 1
# i ⟶ 1
# s ⟶ 5
# t ⟶ 7
# You can use your own dictionary or you can simply open ../../../data/dictionary.txt (relative to your script’s location in our GitHub repository) to access the dictionary of common words from Week #161.
# Optional Extras (for an 0xAddedFee, of course!)
# Limit the number of “special” letter substitutions in any one result to keep that result at least somewhat comprehensible. (0x51105010 is an actual example from my sample solution you may wish to avoid!)
# Find phrases of words that total 8 characters in length (e.g., 0xFee1Face), rather than just individual words.

# read the dictionary with Path::Tiny and return an array of words
use Path::Tiny 'path';
use feature 'say';

my @dictionary = path('../../../data/dictionary.txt')->lines( { chomp => 1 } );

sub find_hex_words {
    my $dictionary = shift;
    my @words;
    foreach my $word (@dictionary) {
        next if length $word < 2;
        next if length $word > 8;
        $word =~ tr/olist/01157/;

        if ( $word =~ /^[0-9a-f]+$/ ) {
            push @words, $word;
        }
    }
    return \@words;
}

my $hex_words = find_hex_words( \@dictionary );

# print a few random hex words
say "Random hex words:";
printf "0x%s\n", $hex_words->[ int( rand( scalar @$hex_words ) ) ] for 1 .. 5;

# Limit the number of “special” letter substitutions in any one result to keep that result at least somewhat comprehensible. (0x51105010 is an actual example from my sample solution you may wish to avoid!)
my @legible_hex_words = grep { !m/\d{2,}/ } @{ find_hex_words( \@dictionary ) };
say "Legible hex words:";
printf "0x%s\n", $legible_hex_words[ int( rand( scalar @legible_hex_words ) ) ]
  for 1 .. 5;

# randomly combine words from $hex_words to make 8 letter strings
my @eight_char_phrases;

# iterate through the hex words
foreach my $hex_word (@$hex_words) {

    # iterate through the hex words again
    foreach my $hex_word2 (@$hex_words) {

 # if the combination is 8 chars, use ucfist on the 2nd and push the combination
        if ( length( $hex_word . $hex_word2 ) == 8 ) {
            my $ucfirst = ucfirst( lc($hex_word2) );
            push @eight_char_phrases, $hex_word . $ucfirst;
        }
    }
}

say "Random 8-letter phrases:";
printf "0x%s\n",
  $eight_char_phrases[ int( rand( scalar @eight_char_phrases ) ) ]
  for 1 .. 5;
