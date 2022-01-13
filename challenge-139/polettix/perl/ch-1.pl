#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
say jort_sort(@ARGV) ? 1 : 0;
sub jort_sort (@args) {
   for (sort @args) { return 0 unless $_ == shift @args }
   return 1
}
