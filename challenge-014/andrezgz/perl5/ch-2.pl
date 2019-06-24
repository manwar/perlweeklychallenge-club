#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-012/
# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S. states,
# write a script to find the longest English word you can spell?
# Here is the list of U.S. states abbreviations as per wikipedia page.
#  https://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations
# This challenge was proposed by team member Neil Bowers.
#
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

use strict;
use warnings;

die "Usage: $0 <words_file>" unless $ARGV[0];

my $words_file = $ARGV[0];
open(my $fh, "<", $words_file) or die "Could not open words file '$words_file': $!";

my %usps = (
    AL => 'Alabama',       AK => 'Alaska',      AZ => 'Arizona',        AR => 'Arkansas',      CA => 'California',
    CO => 'Colorado',      CT => 'Connecticut', DE => 'Delaware',       FL => 'Florida',       GA => 'Georgia',
    HI => 'Hawaii',        ID => 'Idaho',       IL => 'Illinois',       IN => 'Indiana',       IA => 'Iowa',
    KS => 'Kansas',        KY => 'Kentucky',    LA => 'Louisiana',      ME => 'Maine',         MD => 'Maryland',
    MA => 'Massachusetts', MI => 'Michigan',    MN => 'Minnesota',      MS => 'Mississippi',   MO => 'Missouri',
    MT => 'Montana',       NE => 'Nebraska',    NV => 'Nevada',         NH => 'New Hampshire', NJ => 'New Jersey',
    NM => 'New Mexico',    NY => 'New York',    NC => 'North Carolina', ND => 'North Dakota',  OH => 'Ohio',
    OK => 'Oklahoma',      OR => 'Oregon',      PA => 'Pennsylvania',   RI => 'Rhode Island',  SC => 'South Carolina',
    SD => 'South Dakota',  TN => 'Tennessee',   TX => 'Texas',          UT => 'Utah',          VT => 'Vermont',
    VA => 'Virginia',      WA => 'Washington',  WV => 'West Virginia',  WI => 'Wisconsin',     WY => 'Wyoming'
);

my @max = ('');
while( my $word = <$fh> ) {
    chomp $word; # remove new line trailing string

    next if length $word < length $max[0];               # shorter than max
    next if $word !~ /^[a-z]+$/i;                        # non-alphabetic characters
    next if length($word) % 2 != 0;                      # odd number of characters
    next if grep { !$usps{uc $_} } $word =~ m/../g;      # non usps pair of alphabetic characters

    ( length $word > length $max[0] )
        ? @max = ($word)    #reset the list
        : push @max,$word;  #add to the list

}
close $fh;

print 'Longest words: '. join(', ', @max)."\n\n";

print "Sum of states for each word:\n"; #Just for fun
print join(' + ', map { $usps{uc $_} } map { $_ =~ m/../g } $_ ) .' = '. $_ ."\n" for @max ;


__END__

Longest words: Concorde, Ganymede, Mandarin, calamine, mainland, malarial, mandarin, memorial, moorland

Sum of states for each word:
Colorado + North Carolina + Oregon + Delaware = Concorde
Georgia + New York + Maine + Delaware = Ganymede
Massachusetts + North Dakota + Arkansas + Indiana = Mandarin
California + Louisiana + Michigan + Nebraska = calamine
Massachusetts + Indiana + Louisiana + North Dakota = mainland
Massachusetts + Louisiana + Rhode Island + Alabama = malarial
Massachusetts + North Dakota + Arkansas + Indiana = mandarin
Maine + Missouri + Rhode Island + Alabama = memorial
Missouri + Oregon + Louisiana + North Dakota = moorland
