#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say maximum_product(@ARGV);

sub maximum_product (@list) {
   @list = sort { $a <=> $b } @list;
   my $below = $list[0] * $list[1] * $list[-1];
   my $above = $list[-3] * $list[-2] * $list[-1];
   return $below > $above ? $below : $above;
}
