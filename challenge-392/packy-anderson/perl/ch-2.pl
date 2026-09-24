#!/usr/bin/env perl
use v5.44;

use List::MoreUtils qw( frequency );

sub common($first, $second) {
  my %bag1 = frequency split //, $first;
  my %bag2 = frequency split //, $second;
  for my $c (keys %bag1) {
    return true if exists $bag2{$c};
  }
  return false;
}

sub wlp(@words) {
  @words = sort {length($b) cmp length($a) || $b cmp $a} @words;
  for my $i (0 .. $#words - 1) {
    for my $j ($i+1 .. $#words) {
      next if common($words[$i], $words[$j]);
      return length($words[$i]) * length($words[$j]);
    }
  }
  return 0;
}

sub solution($words) {
  say 'Input: @words = (' . join(', ', map {qq/"$_"/} @$words) . ')';
  say 'Output: ' . wlp(@$words);
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
