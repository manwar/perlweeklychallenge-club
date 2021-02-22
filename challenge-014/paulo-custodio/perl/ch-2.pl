#!/usr/bin/perl

# Challenge 014
#
# Challenge #2
# Using only the official postal (2-letter) abbreviations for the 50 U.S.
# states, write a script to find the longest English word you can spell? Here
# is the list of U.S. states abbreviations as per wikipedia page. This challenge
# was proposed by team member Neil Bowers.
#
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari

use strict;
use warnings;
use 5.030;
use Locale::US;

my $u = Locale::US->new;
my @codes = $u->all_state_codes;        # all states two letter codes
my $codes = join("|", @codes);          # regex to match any codes
my $regex = qr/^($codes)+$/i;           # regex to match word composed of codes

# find all words that match, save longest ones
my @longest;
open(my $fh, "<", "words.txt") or die "open words.txt: $!\n";
while (<$fh>) {
    chomp;
    next unless /$regex/;               # filter words that match state codes
    if (!@longest || length($_) > length($longest[0])) {
        @longest = ($_);
    }
    elsif (length($_) == length($longest[0])) {
        push @longest, $_;
    }
}

# show longest words in form: word = state + state + ...
for my $word (@longest) {
    my @states = map {$_ = $u->{code2state}{uc($_)}} grep {$_} split /(..)/, $word;
    say $word, " = ", join(" + ", @states);
}
