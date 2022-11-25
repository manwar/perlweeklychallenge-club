#!/usr/bin/env perl
use strict;
use warnings;

sub binary_flip{
  my ($n) = @_;
  ~$n & (2**(log($n)/log(2))-1);
}

print binary_flip(5), "\n";
print binary_flip(4), "\n";
print binary_flip(6), "\n";

