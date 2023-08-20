#!/usr/bin/perl
use v5.36;

my $pattern = shift;
my $count;
for (@ARGV) {$count++ if $_ =~ /^$pattern/}
say $count // 0;
