#!/usr/bin/env perl
use v5.38;

use List::Util qw( reduce );

sub concatString {
  my($num, $arr) = @_;
  my $word = reduce { $a . $b } @$arr;
  my $words = "\nUsing \@arr$num, word$num => \""
            . join('" . "', @$arr)
            . '" => "' . $word . '"';
  return ($word, $words);
}

sub sameString {
  my ($arr1, $arr2) = @_;
  my ($word1, $words1) = concatString(1, $arr1);
  my ($word2, $words2) = concatString(2, $arr2);
  return($word1 eq $word2, $words1 . $words2);
}

sub solution {
  my ($arr1, $arr2) = @_;
  say 'Input: @arr1 = ("' . join('", "', @$arr1) . '")';
  say '       @arr2 = ("' . join('", "', @$arr2) . '")';
  my ($same, $words) = sameString($arr1, $arr2);
  say 'Output: ' . ($same ? 'true' : 'false');
  say $words;
}

say "Example 1:";
solution(["ab", "c"], ["a", "bc"]);

say "\nExample 2:";
solution(["ab", "c"], ["ac", "b"]);

say "\nExample 3:";
solution(["ab", "cd", "e"], ["abcde"]);