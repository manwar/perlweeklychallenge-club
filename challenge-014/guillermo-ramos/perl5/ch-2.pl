#!/usr/bin/env perl
#
# Using only the official postal (2-letter) abbreviations for the 50
# U.S. states, write a script to find the longest English word you can spell?
# (https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations)
################################################################################

use strict;
use warnings;

use List::Util qw<max>;
# https://github.com/dwyl/english-words
my $DICTPATH = shift or die "Usage: $0 <dict>\n";

# Extracted from Wikipedia + some Emacs macro wizardry
my %STATES = ( AK => 'Alaska', AL => 'Alabama', AR => 'Arkansas', AZ => 'Arizona',
    CA => 'California', CO => 'Colorado', CT => 'Connecticut', DE => 'Delaware', FL
    => 'Florida', GA => 'Georgia', HI => 'Hawaii', IA => 'Iowa', ID => 'Idaho', IL =>
    'Illinois', IN => 'Indiana', KS => 'Kansas', KY => 'Kentucky', LA =>
    'Louisiana', MA => 'Massachusetts', MD => 'Maryland', ME => 'Maine', MI =>
    'Michigan', MN => 'Minnesota', MO => 'Missouri', MS => 'Mississippi', MT =>
    'Montana', NC => 'North Carolina', ND => 'North Dakota', NE => 'Nebraska', NH =>
    'New Hampshire', NJ => 'New Jersey', NM => 'New Mexico', NV => 'Nevada', NY =>
    'New York', OH => 'Ohio', OK => 'Oklahoma', OR => 'Oregon', PA =>
    'Pennsylvania', RI => 'Rhode Island', SC => 'South Carolina', SD => 'South Dakota',
    TN => 'Tennessee', TX => 'Texas', UT => 'Utah', VA => 'Virginia', VT =>
    'Vermont', WA => 'Washington', WI => 'Wisconsin', WV => 'West Virginia', WY =>
    'Wyoming' );
my @ABBREVS = keys %STATES;

# For efficiency, keep the longest word found while filtering suitable words
my $max_len = 0;

# Given a word, return whether it can be composed using state abbreviations
sub suitable {
    $_ =~ s/^\s+|\s+$//g; # Trim

    my $len = length $_;
    return 0 if $len % 2 != 0; # Length must be even

    # Iterate word in 2-letter chunks checking they are valid abbreviations
    foreach my $i (0 .. $len/2-1) {
        my $abbrev = uc(substr($_, $i*2, 2));
        return 0 unless grep /^$abbrev$/, @ABBREVS;
    }

    $max_len = max $max_len, $len; # Update max_len if needed
    return 1;
}

# Read words from $DICTPATH and store suitable ones in @suitable_words
open(my $dictd, '<', $DICTPATH) or die 'Unable to open dictionary: $!';
my @suitable_words = grep suitable, <$dictd>;
close($dictd);

# Find the longest word(s)...
for my $word (@suitable_words) {
    my $len = length $word;
    if ($len == $max_len) {
        # ... and print their composition (states)
        my @states;
        foreach my $i (0 .. $len/2-1) {
            my $abbrev = uc(substr($word, $i*2, 2));
            push @states, $STATES{$abbrev};
        }
        print join(" + ", @states), " = $word\n";
    }
}
