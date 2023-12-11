#!/usr/bin/env raku
use v6;

sub findPandQ(@a) {
  my $p = (@a[2] * @a[2] - @a[1] * @a[3])
        / (@a[0] * @a[2] - @a[1] * @a[1]);
  my $q = (@a[0] * @a[3] - @a[2] * @a[1])
        / (@a[0] * @a[2] - @a[1] * @a[1]);
  return($p, $q);
}

sub isLinearRecurranceOfSecondOrder(@a) {
  my ($p1, $q1) = findPandQ(@a[0 .. 3]);
  my ($p2, $q2) = findPandQ(@a[1 .. 4]);
  if ($p1 != $p2 || $q1 != $q2) {
    say "Values for P ($p1, $p2) and Q ($q1, $q2) "
      ~ "are not consistent across all five elements";
    return False;
  }
  if ($p1 != $p1.Int || $q1 != $q1.Int) {
    say "Values for P ($p1) and Q ($q1) for first "
      ~ "four elements are not integers";
    return False;
  }
  say "Found integer values for P ($p1) and Q ($q1)";
  return True;
}

sub solution(*@a) {
  say 'Input: @a = (' ~ @a.join(', ') ~ ')';
  my $result = isLinearRecurranceOfSecondOrder(@a);
  say 'Output: ' ~ $result;
}

say "Example 1:";
solution(1, 1, 2, 3, 5);

say "\nExample 2:";
solution(4, 2, 4, 5, 7);

say "\nExample 3:";
solution(4, 1, 2, -3, 8);