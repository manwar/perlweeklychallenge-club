#!/usr/bin/env raku
use v6;

sub concatString($num, @arr) {
  my $word = [~] @arr;
  my $words = "\nUsing \@arr$num, word$num => \""
            ~ @arr.join('" . "')
            ~ '" => "' ~ $word ~ '"';
  return ($word, $words);
}

sub sameString(@arr1, @arr2) {
  my ($word1, $words1) = concatString(1, @arr1);
  my ($word2, $words2) = concatString(2, @arr2);
  return($word1 eq $word2, $words1 ~ $words2);
}

sub solution(@arr1, @arr2) {
  say 'Input: @arr1 = ("' ~ @arr1.join('", "') ~ '")';
  say '       @arr2 = ("' ~ @arr2.join('", "') ~ '")';
  my ($same, $words) = sameString(@arr1, @arr2);
  say 'Output: ' ~ ($same ?? 'true' !! 'false');
  say $words;
}

say "Example 1:";
solution(["ab", "c"], ["a", "bc"]);

say "\nExample 2:";
solution(["ab", "c"], ["ac", "b"]);

say "\nExample 3:";
solution(["ab", "cd", "e"], ["abcde"]);