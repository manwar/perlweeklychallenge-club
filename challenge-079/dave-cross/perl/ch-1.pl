#!/usr/bin/perl

use strict;
use warnings;
use feature qw[say signatures];
no warnings 'experimental::signatures';

if (!@ARGV or !$ARGV[0] or $ARGV[0] =~ /\D/) {
  die "Please give me a positive integer\n";
}

my $n = shift;

my $count;

for (1 .. $n) {
  $count += set_bits_in($_);
}

say "$count % 1000000007 = $count";

sub set_bits_in($decimal) {
  sprintf('%b', $decimal) =~ tr/1/1/;
}
