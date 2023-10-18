#!/usr/bin/env perl
use v5.38;

sub consistentCount {
  my($allowed, $str) = @_;
  my $regex = '^[' . $allowed . ']+$';
  my $count = 0;
  foreach my $s ( @$str ) {
    $count++ if $s =~ /$regex/;
  }
  return $count;
}

sub solution {
  my($allowed, $str) = @_;
  say 'Input: @str = ("' . join('", "', @$str) . '")';
  say '       $allowed = "' . $allowed . '"';
  my $output = consistentCount($allowed, $str);
  say 'Output: ' . $output;
}

say "Example 1:";
solution("ab", ["ad", "bd", "aaab", "baa", "badab"]);

say "\nExample 2:";
solution("abc", ["a", "b", "c", "ab", "ac", "bc", "abc"]);

say "\nExample 3:";
solution("cad", ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]);