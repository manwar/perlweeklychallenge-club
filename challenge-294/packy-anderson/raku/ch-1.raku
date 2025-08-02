#!/usr/bin/env raku
use v6;

sub consecutiveSequence(@ints) {
  my %count = @ints.Bag; # count the occurences
  my $max   = @ints.max; # find the max value
  my $maxSeq = 1;
  my $seq = 0;
  for 0 .. $max -> $i {
    if (%count{$i}.defined && %count{$i} > 0) {
      $seq++; # we've found a consecutive value
      if ($seq > $maxSeq) {
        $maxSeq = $seq; # keep track of the longest
      }
    }
    else {
      $seq = 0; # the sequence broke
    }
  }
  # we want sequences longer than one value
  return $maxSeq > 1 ?? $maxSeq !! -1;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ consecutiveSequence(@ints);
}

say "Example 1:";
solution([10, 4, 20, 1, 3, 2]);

say "\nExample 2:";
solution([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]);

say "\nExample 3:";
solution([10, 30, 20]);
