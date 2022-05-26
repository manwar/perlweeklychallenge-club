#!/usr/bin/env perl
# Perl weekly challenge 166
# Task 1: hexadecimal words
#
# See https://wlmb.github.io/2022/05/25/PWC166/#task-1-hexadecimal-words
use v5.12;
use warnings;
# Parameters
my $N_phrases=100; # number of desird phrases
my $phrase_size=8;
my $max_trans=1; # maximum characters to transliterate
my $min_size=2; # bounds on word size
my $max_size=$phrase_size-$min_size;

my @words; # set of sets of words, one for each size
while(<>){ # read dictionary words, one perl line
    chomp;
    # discard words too small, too large or with non-hex-like characters
    next unless $min_size <= length($_) <= $max_size and /^\s*[0-9a-folist]+\s*$/;
    next unless tr/olist/01157/ <= $max_trans; # transliterate letters, but too many
    push @{$words[length($_)]}, $_; # found a word? save it
}
for(1..$N_phrases){
    my $phrase="";
    while(length($phrase)<$phrase_size){
        my $size=$min_size+rand($max_size+1-length($phrase));# choose size of next word
        my $chosen=$words[$size]; # array of words with chosen size
        $phrase.=ucfirst $chosen->[rand @$chosen]; # add random word of given length
	$phrase="" if length($phrase)>$phrase_size; # restart if overshoot
    }
    say $phrase;
}
