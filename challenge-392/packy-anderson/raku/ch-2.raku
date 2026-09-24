#!/usr/bin/env raku
use v6;

sub common($first, $second) {
  my %bag1 = $first.comb.Bag;
  my %bag2 = $second.comb.Bag;
  for %bag1.keys -> $c {
    return True if $c ∈ %bag2;
  }
  return False;
}

sub wlp(@words is copy) {
  @words = @words.sort: {$^b.chars cmp $^a.chars || $^b cmp $^a};
  for 0 .. @words.end - 1 -> $i {
    for $i+1 .. @words.end -> $j {
      next if common(@words[$i], @words[$j]);
      return @words[$i].chars * @words[$j].chars;
    }
  }
  return 0;
}

sub solution(@words) {
  say 'Input: @words = (' ~ @words.map({qq/"$_"/}).join(', ') ~ ')';
  say 'Output: ' ~ wlp(@words);
}

say "Example 1:";
solution(["a", "ab", "abc", "d", "de", "def"]);

say "\nExample 2:";
solution(["a", "aa", "aaa", "aaaa"]);

say "\nExample 3:";
solution(["meet", "app", "code", "sky", "bold"]);

say "\nExample 4:";
solution(["a", "ab", "abc", "abcd", "efghi"]);

say "\nExample 5:";
solution(["xyz", "w", "abcdefg", "hij"]);
