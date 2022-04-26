#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-161/
# TASK #1 > Abecedarian Words
#
# An abecedarian word is a word whose letters are arranged in alphabetical order.
# For example, "knotty" is an abecedarian word, but "knots" is not.
# Output or return a list of all abecedarian words in the dictionary,
#  sorted in decreasing order of length.
#
# Optionally, using only abecedarian words, leave a short comment in your code
#  to make your reviewer smile.

use strict;
use warnings;
use feature 'say';

my @abc;
open(my $fh, '<', 'dictionary.txt') or die "dictionary.txt not found\n";
while(my $w = <$fh>) {
    chomp $w;
    my $sorted = join '', sort split //, $w;
    push @abc, $w if $w eq $sorted;
}
close $fh;
say join "\n", reverse sort {length($a) <=> length($b)} @abc;

# To my reviewer:
# As loops allow flow, it aims no glory at all, fizz-buzz is my joy.
