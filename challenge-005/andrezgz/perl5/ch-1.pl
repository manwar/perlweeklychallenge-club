#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-005/
# Challenge #1
# Write a program which prints out all anagrams for a given word.
# For more information about Anagram, please check this wikipedia page.
# https://en.wikipedia.org/wiki/Anagram

# An anagram may be a phrase, but I limit this code only to words of the same length as the given one,
# because even if I can make a phrase (string of words using the considered letters) it may not have sense.

# I've reused code from the previous challenge
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-004/andrezgz/perl5/ch-2.pl

use strict;
use warnings;

die "Usage: ch-1.pl <words_file> <word>" if scalar(@ARGV) < 2;

my $words_file = $ARGV[0];
my $given_word = $ARGV[1];

open(my $fh, "<", $words_file) or die "Could not open words file '$words_file': $!";

while( my $word = <$fh> ) {
    chomp $word; #remove new line trailing string
    print $word.$/ if is_word_anagram( lc $word , lc $given_word);
}
close $fh;

#Return 1 if $word is an anagram for $given_word
sub is_word_anagram {
    my ( $word, $given_word ) = @_;

    return 0 if ( length $word != length $given_word ); #all letters must be used in a word anagram
    return 0 if ( $word eq $given_word );               #the word must not be the given one

    my %letters = get_hashed_letters($given_word);

    foreach my $l (split //,$word ){
        return 0 unless (exists $letters{ $l } && $letters{ $l } > 0);
        $letters{ $l }--;
    }
    return 1;
}

{
    my %letters; #generate the hash only once

    #Make a hash with available letters and quantity
    sub get_hashed_letters {
        my ( $given_word ) = @_;
        return %letters if (keys %letters);
        for my $l (split //,$given_word ){
            $letters{ lc($l) }++;
        }
        return %letters
    }
}
