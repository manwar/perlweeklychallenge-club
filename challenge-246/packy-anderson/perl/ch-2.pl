#!/usr/bin/env perl
use v5.38;

sub findPandQ {
  my @a = @_;
  my $p = ($a[2] * $a[2] - $a[1] * $a[3])
        / ($a[0] * $a[2] - $a[1] * $a[1]);
  my $q = ($a[0] * $a[3] - $a[2] * $a[1])
        / ($a[0] * $a[2] - $a[1] * $a[1]);
  return($p, $q);
}

sub isLinearRecurranceOfSecondOrder {
  my @a = @_;
  my ($p1, $q1) = findPandQ(@a[0 .. 3]);
  my ($p2, $q2) = findPandQ(@a[1 .. 4]);
  if ($p1 != $p2 || $q1 != $q2) {
    say "Values for P ($p1, $p2) and Q ($q1, $q2) "
      . "are not consistent across all five elements";
    return 0;
  }
  if ($p1 != int($p1) || $q1 != int($q1)) {
    say "Values for P ($p1) and Q ($q1) for first "
      . "four elements are not integers";
    return 0;
  }
  say "Found integer values for P ($p1) and Q ($q1)";
  return 1;
}

sub solution {
  my @a = @_;
  say 'Input: @a = (' . join(', ', @a) . ')';
  my $result = isLinearRecurranceOfSecondOrder(@a);
  say 'Output: ' . ($result ? 'true' : 'false');
}

say "Example 1:";
solution(1, 1, 2, 3, 5);

say "\nExample 2:";
solution(4, 2, 4, 5, 7);

say "\nExample 3:";
solution(4, 1, 2, -3, 8);