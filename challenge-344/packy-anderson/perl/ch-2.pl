#!/usr/bin/env perl
use v5.40;

use Algorithm::Combinatorics qw(permutations);

sub formation($source, $target) {
  my @source = map { join('', @$_) } @$source;
  $target = join('', @$target);
  my $iter = permutations(\@source);
  while (my $perm = $iter->next) {
    return 'true' if join('', @$perm) eq $target;
  }
  return 'false';
}

sub solution($source, $target) {
  my @arr = map { '[' . join(',', @$_) . ']'} @$source;
  say 'Input: @source = (' . join(', ', @arr) . ')';
  say '       @target = (' . join(', ', @$target) . ')';
  say 'Output: ' . formation($source, $target);
}

say "Example 1:";
solution([[2,3], [1], [4]], [1, 2, 3, 4]);

say "\nExample 2:";
solution([[1,3], [2,4]], [1, 2, 3, 4]);

say "\nExample 3:";
solution([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]);

say "\nExample 4:";
solution([[1], [3]], [1, 2, 3]);

say "\nExample 5:";
solution([[7,4,6]], [7,4,6]);
