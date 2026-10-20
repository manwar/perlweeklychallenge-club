#!/usr/bin/env perl
use v5.44;

sub isTrionic(@arr) {
  my ($p, $q);
  my $mode = 0;
  for my $i (1 .. $#arr) {
    my $curr = $arr[$i];
    my $last = $arr[$i-1];
    if ($last == $curr) {
      return "false", -1, -1; # no strict increase or decrease
    }
    if ($mode == 0) {
      next unless $last > $curr;
      $mode = 1; # proceed to strictly decreasing
      $p = $i - 1;
    }
    elsif ($mode == 1) {
      next unless $last < $curr;
      $mode = 2; # proceed to strictly increasing
      $q = $i - 1;
    }
    elsif ($mode == 2) {
      next unless $last >= $curr;
      return "false", -1, -1; # no strict increase
    }
  }
  return "false", -1, -1 unless $mode == 2;
  return "true", $p, $q;
}

sub solution($arr) {
  say 'Input: @arr = (' . join(', ', @$arr) . ')';
  my ($result, $p, $q) = isTrionic(@$arr);
  say "Output: $result";
  say "\nChoose p = $p and q = $q" if $result eq "true";
}

say "Example 1:";
solution([1, 3, 5, 4, 2, 6, 8]);

say "\nExample 2:";
solution([1, 4, 4, 2, 1, 3, 5]);

say "\nExample 3:";
solution([2, 10, 3, 1, 9]);

say "\nExample 4:";
solution([1, 2, 3, 4, 3, 2, 1]);

say "\nExample 5:";
solution([1, 3, 6, 4, 2, 7, 8, 4]);
