#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say summations(@ARGV);

sub summations (@n) {
   for (2 .. $#n) { $n[$_] += $n[$_ - 1] for $_ .. $#n }
   return $n[-1];
}
