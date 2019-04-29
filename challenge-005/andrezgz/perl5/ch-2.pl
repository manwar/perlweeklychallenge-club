#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-005/
# Challenge #2
# Write a program to find the sequence of characters that has the most anagrams.

# An anagram may be a phrase, but I limit this code only to words of the same length as the given one,
# because even if I can make a phrase (string of words using the considered letters) it may not have sense.

use strict;
use warnings;

die "Usage: ch-2.pl <words_file>" if scalar(@ARGV) != 1;

my $words_file = $ARGV[0];

open(my $fh, "<", $words_file) or die "Could not open words file '$words_file': $!";

my %anagrams;
my %candidates;
my $max_anagrams = 0;

while( my $word = <$fh> ) {
    chomp $word; #remove new line trailing string

    my $k = join( '', sort split //, lc $word); #identifier for words with same letters
    push @{$anagrams{$k}}, $word;

    my $k_anagrams = @{$anagrams{$k}};
    next if ($k_anagrams < $max_anagrams);                          # not a candidate right now
    $candidates{$k} = 1;                                            # it's a candidate
    $max_anagrams = $k_anagrams if ( $k_anagrams > $max_anagrams ); # the best candidate at the moment

}
close $fh;

print "Sequence of characters with the most anagrams ($max_anagrams)".$/;

#Check only candidates to avoid looping over the complete %anagrams hash
foreach my $k (keys %candidates) {
    next if @{$anagrams{$k}} != $max_anagrams;
    print join( ',', split //, $k)
        . " => "
        . join(",", sort {lc($a) cmp lc($b)} @{$anagrams{$k}}) . $/;
}
