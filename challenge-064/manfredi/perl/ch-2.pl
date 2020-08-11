#!/usr/bin/env perl

# Perl Week Challenge 064 - Task #2
# You are given a string $S and an array of words @W.
# Write a script to find out if $S can be split into
# sequence of one or more words as in the given @W.
# Print the all the words if found otherwise print 0.

use strict;
my (@words, $words, $string, %pos);

$string = 'perlweeklychallenge';
@words  = ("weekly", "challenge", "perl");

# $string = 'perlandraku';
# @words  = ("python", "ruby", "haskell");

$words = join '', @words;

print 0 and exit if length($string) != length($words);

for my $word (@words) {
   my $i = index($string, $word);
   print 0 and exit if $i == -1;
   $pos{chr($i)} = $word;
}

my @result = map { $pos{$_} } sort keys %pos;
print "@result\n";

