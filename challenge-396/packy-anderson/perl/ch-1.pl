#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( any );

sub finishingOrder($order, $friends) {
  grep { my $f = $_; any { $f == $_ } @$friends } @$order;
}

sub solution($order, $friends) {
  say 'Input: @order   = (' . join(', ', @$order) . ')';
  say '       @friends = (' . join(', ', @$friends) . ')';
  say 'Output: (' . join(', ', finishingOrder($order, $friends)) . ')';
}

say "Example 1:";
solution([3, 1, 4, 2, 5],[1, 2, 4]);

say "\nExample 2:";
solution([5, 4, 3, 2, 1],[1, 3, 5]);

say "\nExample 3:";
solution([2, 4, 1, 3],[1, 2, 3, 4]);

say "\nExample 4:";
solution([4, 1, 3, 2],[3]);

say "\nExample 5:";
solution([1, 3, 2, 6, 5, 4],[1, 2, 3]);
