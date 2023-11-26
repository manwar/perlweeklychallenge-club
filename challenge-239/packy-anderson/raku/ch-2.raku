#!/usr/bin/env raku
use v6;

sub consistentCount($allowed, @str) {
  my $regex = '^ <[' ~ $allowed ~ ']>+ $';
  my $count = 0;
  for @str -> $s {
    $count++ if $s.match: / <$regex> /;
  }
  return $count;
}

sub solution($allowed, @str) {
  say 'Input: @str = ("' ~ @str.join('", "') ~ '")';
  say '       $allowed = "' ~ $allowed ~ '"';
  my $output = consistentCount($allowed, @str);
  say 'Output: ' ~ $output;
}

say "Example 1:";
solution("ab", ["ad", "bd", "aaab", "baa", "badab"]);

say "\nExample 2:";
solution("abc", ["a", "b", "c", "ab", "ac", "bc", "abc"]);

say "\nExample 3:";
solution("cad", ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]);