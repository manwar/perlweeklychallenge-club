#!/usr/bin/env perl
use v5.40;

use Set::Intersection;

sub countCommon($words1, $words2) {
  # make Bags that count the words
  my %counts1; map { $counts1{lc $_}++ } @$words1;
  my %counts2; map { $counts2{lc $_}++ } @$words2;

  # filter to get set of words occuring only once
  my @counts1 = grep { $counts1{$_} == 1 } keys %counts1;
  my @counts2 = grep { $counts2{$_} == 1 } keys %counts2;

  # find the elements common in both
  my @common = get_intersection(\@counts1, \@counts2);
  return scalar(@common);
}

sub solution($words1, $words2) {
  say 'Input: @words1 = (' . join(', ', map { qq{"$_"} } @$words1) . ')';
  say '       @words2 = (' . join(', ', map { qq{"$_"} } @$words2) . ')';
  say 'Output: ' . countCommon($words1, $words2);
}

say "Example 1:";
solution(["Perl", "is", "my", "friend"],
         ["Perl", "and", "Raku", "are", "friend"]);

say "\nExample 2:";
solution(["Perl", "and", "Python", "are", "very", "similar"],
         ["Python", "is", "top", "in", "guest", "languages"]);

say "\nExample 3:";
solution(["Perl", "is", "imperative", "Lisp", "is", "functional"],
         ["Crystal", "is", "similar", "to", "Ruby"]);
