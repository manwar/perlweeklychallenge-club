#!/usr/bin/perl

use strict;
use warnings;

my $match_word = pop(@ARGV);
my @words = @ARGV or die "Usage: word(s) matchword\n";

my $build_word;
foreach my $word (@words) {
    $build_word .= substr($word,0,1);
}
if ($build_word eq $match_word) {
    exit 0;
} else {
    exit 1;
}

__END__
TASK #1: Acronyms

You are given an array of words and a word. Write a script to return true if concatenating 
the first letter of each word in the given array matches the given word, return false otherwise.
