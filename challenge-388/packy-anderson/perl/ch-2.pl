#!/usr/bin/env perl
use v5.44;

use Algorithm::Combinatorics qw(permutations);

sub secretSanta($n) {
  my @valid;
  my $iter = permutations([1 .. $n]);
  while (my $perm = $iter->next) {
    my $is_valid = 1;
    for my $i ( 0 .. $n-1 ) {
      if (@$perm[$i] == $i+1) {
        $is_valid = 0;
        last;
      }
    }
    push @valid, $perm if $is_valid;
  }
  scalar @valid;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  say 'Output: ' . secretSanta($n);
}

say "Example 1:";
solution(1);

say "\nExample 2:";
solution(2);

say "\nExample 3:";
solution(3);

say "\nExample 4:";
solution(4);

say "\nExample 5:";
solution(5);
