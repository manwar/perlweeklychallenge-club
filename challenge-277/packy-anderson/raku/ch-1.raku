#!/usr/bin/env raku
use v6;

sub countCommon(@words1, @words2) {
  # make Bags that count the words
  my %counts1 = @words1.map({ $_.lc }).Bag;
  my %counts2 = @words2.map({ $_.lc }).Bag;

  # filter to get set of words occuring only once
  my @counts1 = %counts1.keys.grep({ %counts1{$_} == 1});
  my @counts2 = %counts2.keys.grep({ %counts2{$_} == 1});

  # find the elements common in both
  my @common = @counts1 ∩ @counts2;
  return @common.elems;
}

sub solution(@words1, @words2) {
  say 'Input: @words1 = (' ~ @words1.map({qq{"$_"}}).join(', ') ~ ')';
  say '       @words2 = (' ~ @words2.map({qq{"$_"}}).join(', ') ~ ')';
  say 'Output: ' ~ countCommon(@words1, @words2);
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
