#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say for missing_numbers(@ARGV);

sub missing_numbers (@array) {
   my %set = map { $_ => 1 } @array;
   grep { ! exists($set{$_}) } 0 .. @array;
}
