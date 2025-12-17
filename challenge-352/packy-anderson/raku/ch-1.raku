#!/usr/bin/env raku
use v6;

sub matchString(@words) {
  my @matches;
  my %seen;
  for 0..@words.end -> $i {
    my $substring = @words[$i];
    # skip if we've already considered this substring
    next if %seen{$substring}++;
    for 0..@words.end -> $j {
      # we're not matching substrings against themselves
      next if $i == $j;
      my $string = @words[$j];
      # skip $string if $substring doesn't match
      next if $string.index($substring) === Nil;
      # save the matched substring
      @matches.push($substring);
      # it matches at least one, we don't have to check the rest
      last;
    }
  }
  return @matches;
}

sub solution(@words) {
  say 'Input: @words = (' ~ @words.map({qq{"$_"}}).join(', ')
    ~ ')';
  my @output = matchString(@words);
  say 'Output: (' ~ @output.map({qq{"$_"}}).join(', ') ~ ')';
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
