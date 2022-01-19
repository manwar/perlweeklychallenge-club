#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

for my $n (@ARGV) {
   defined(my $pid = fork()) or die "fork(): $!\n";
   next if $pid;
   sleep $n;
   say $n;
   exit 0;
}
wait for 1 .. @ARGV;
