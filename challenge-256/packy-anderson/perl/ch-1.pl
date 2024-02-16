#!/usr/bin/env perl
use v5.38;

sub maximumPairs(@words) {
  my $count = 0;
  while (@words) {
    # the the first word off the list
    my $first = shift @words;
    # now compare to the rest of the words in the list
    for my $i (0 .. $#words) {
      my $second = $words[$i];
      if ($first eq reverse $second) {
        # we found a pair
        $count++;
        # remove @words[$i] from the list
        splice(@words, $i, 1);
        # we don't need to compare any more words to $first
        last;
      }
    }
  }
  return $count;
}

sub solution(@words) {
  say 'Input: @words = ("' . join('", "', @words) . '")';
  my $count = maximumPairs(@words);
  say 'Output: ' . $count;
}

say "Example 1:";
solution("ab", "de", "ed", "bc");

say "\nExample 2:";
solution("aa", "ba", "cd", "ed");

say "\nExample 3:";
solution("uv", "qp", "st", "vu", "mn", "pq");