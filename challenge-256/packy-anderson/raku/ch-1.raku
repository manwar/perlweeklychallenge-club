#!/usr/bin/env raku
use v6;

sub maximumPairs(@words) {
  my $count = 0;
  while (@words) {
    # the the first word off the list
    my $first = @words.shift;
    # now compare to the rest of the words in the list
    for 0 .. @words.end -> $i {
      my $second = @words[$i];
      if ($first eq $second.flip) {
        # we found a pair
        $count++;
        # remove @words[$i] from the list
        @words.splice($i, 1);
        # we don't need to compare any more words to $first
        last;
      }
    }
  }
  return $count;
}

sub solution(@words) {
  say 'Input: @words = ("' ~ @words.join('", "') ~ '")';
  my $count = maximumPairs(@words);
  say 'Output: ' ~ $count;
}

say "Example 1:";
solution(["ab", "de", "ed", "bc"]);

say "\nExample 2:";
solution(["aa", "ba", "cd", "ed"]);

say "\nExample 3:";
solution(["uv", "qp", "st", "vu", "mn", "pq"]);