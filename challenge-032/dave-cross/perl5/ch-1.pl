#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $csv;
if ($ARGV[0] eq '-csv') {
  shift;
  $csv = 1;
}

my %count;

while (<>) {
  chomp;
  $count{$_}++;
}

for (sort { $count{$b} <=> $count{$a} } keys %count) {
  say $_, ($csv ? ',' : "\t"), $count{$_};
}
