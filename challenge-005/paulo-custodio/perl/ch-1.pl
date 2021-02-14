#!/usr/bin/perl

# Challenge 005
#
# Challenge #1
# Write a program which prints out all anagrams for a given word. For more
# information about Anagram, please check this wikipedia page.
# create a hash of all words in dictionary where key is sorted list of letters
# therefore two anagrams have the same key

use strict;
use warnings;
use 5.030;

# get input
my($word) = @ARGV;
my $word_key = word_key($word);

# read dictionary and print words that match key set
open(my $fh, "<", "words.txt") or die "open words.txt: $!\n";
while (<$fh>) {
    chomp;
    next if /\W/;
    say lc($_) if $word_key eq word_key($_);
}

sub word_key {
    my($word) = @_;
    $word =~ s/\W//g;
    my @letters = sort split //, lc($word);
    return join '', @letters;
}
