#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use List::Util 'sum';

say matching_members(@ARGV);

sub matching_members (@list) {
   my @sorted = sort { $a <=> $b } @list;
   return sum map { $list[$_] == $sorted[$_] ? 1 : 0 } 0 .. $#list;
}
