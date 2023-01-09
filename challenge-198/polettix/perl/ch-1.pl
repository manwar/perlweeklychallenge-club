#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say max_gap(@ARGV ? @ARGV : (2, 5, 8, 1));

sub max_gap (@list) {
   @list = sort { $a <=> $b } @list;
   my $widest_gap = -1;
   my $count = 0;
   for my $i (1 .. $#list) {
      my $gap = $list[$i] - $list[$i - 1];

      # order of the following tests matters, do not change!
      ++$count                          if $gap == $widest_gap;
      ($count, $widest_gap) = (1, $gap) if $gap >  $widest_gap;
   }
   return $count;
}
