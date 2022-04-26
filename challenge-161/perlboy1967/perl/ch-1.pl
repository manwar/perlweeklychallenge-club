#!/bin/perl

=pod

The Weekly Challenge - 161
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-161/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Abecedarian Words
Submitted by: Ryan J Thompson

An abecedarian word is a word whose letters are arranged in alphabetical order. 
For example, “knotty” is an abecedarian word, but “knots” is not. Output or 
return a list of all abecedarian words in the dictionary, sorted in decreasing
order of length.

Optionally, using only abecedarian words, leave a short comment in your code 
to make your reviewer smile.

=cut

use v5.16;

my $dictFile = shift // '../../../data/dictionary.txt';

open(my $fhDict, '<', $dictFile) ||
  die "Can't open dictfile '$dictFile' ($!)";

my %w;
while (<$fhDict>) {
  chomp;
  if ($_ eq join '',sort split //) {
    push(@{$w{length $_}},$_);
  }
}
close($fhDict);

say join("\n",map {join("\n", reverse sort @{$w{$_}})} sort {$b<=>$a} keys %w); 

__END__
Abecedarian quote for Colin: A hot dirty messy hippy chills at empty glossy films
