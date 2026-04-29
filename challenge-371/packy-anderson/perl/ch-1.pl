#!/usr/bin/env perl
use v5.40;

sub missing(@seq) {
  my @diff;
  # determine the differences we know
  foreach my $i (0..3) {
    next if $seq[$i] eq '?' || $seq[$i+1] eq '?';
    $diff[$i] = ord($seq[$i+1]) - ord($seq[$i]);
  }
  # fill in the missing differences
  foreach my $i (0..3) {
    $diff[$i] = $diff[($i +2) % 4] unless defined $diff[$i];
  }
  # special case: the first letter is missing
  if ($seq[0] eq '?') {
    return chr(ord($seq[1]) - $diff[0]);
  }
  # calculate the missing letter
  foreach my $i (1..4) {
    next unless $seq[$i] eq '?';
    return chr(ord($seq[$i-1]) + $diff[$i-1]);
  }
}

sub solution($seq) {
  say 'Input: @arr = qw(' . join(' ', @$seq) . ')';
  say 'Output: ' . missing(@$seq);
}

say "Example 1:";
solution(["a", "c", "?", "g", "i"]);

say "\nExample 2:";
solution(["a", "d", "?", "j" ,"m"]);

say "\nExample 3:";
solution(["a", "e", "?", "m", "q"]);

say "\nExample 4:";
solution(["a", "c", "f", "?", "k"]);

say "\nExample 5:";
solution(["b", "e", "g", "?", "l"]);

say "\nExample 6:";
solution(["?", "t", "v", "x", "z"]);

say "\nExample 7:";
solution(["l", "m", "o", "p", "?"]);