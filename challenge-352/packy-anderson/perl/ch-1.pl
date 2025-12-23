#!/usr/bin/env perl
use v5.40;

sub matchString(@words) {
  my @matches;
  my %seen;
  foreach my $i ( 0 .. $#words ) {
    my $substring = $words[$i];
    # skip if we've already considered this substring
    next if $seen{$substring}++;
    foreach my $j ( 0 .. $#words ) {
      # we're not matching substrings against themselves
      next if $i == $j;
      my $string = $words[$j];
      # skip $string if $substring doesn't match
      next if index($string, $substring) < 0;
      # save the matched substring
      push @matches, $substring;
      # it matches at least one, we don't have to check the rest
      last;
    }
  }
  return @matches;
}

sub solution($words) {
  say 'Input: @words = (' . join(', ', map {qq{"$_"}} @$words)
    . ')';
  my @output = matchString(@$words);
  say 'Output: (' . join(', ', map {qq{"$_"}} @output) . ')';
}

say "Example 1:";
solution(["cat", "cats", "dog", "dogcat", "dogcat", "rat", 
          "ratcatdogcat"]);

say "\nExample 2:";
solution(["hello", "hell", "world", "wor", "ellow",
          "elloworld"]);

say "\nExample 3:";
solution(["a", "aa", "aaa", "aaaa"]);

say "\nExample 4:";
solution(["flower", "flow", "flight", "fl", "fli", "ig", "ght"]);

say "\nExample 5:";
solution(["car", "carpet", "carpenter", "pet", "enter", "pen",
          "pent"]);

