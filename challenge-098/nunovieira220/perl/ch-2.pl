#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @A = (1, 3, 5, 7);
my $N = 6;

# Search Insert Position
my $len = scalar @A;
my $index = $len;
my $exists = 0;

for(my $i = 0; $i < $len; $i++) {
  $exists = 1 if($N == $A[$i]);

  if($N <= $A[$i]) {
    $index = $i;
    last;
  }
}

if(!$exists) {
  my @aux = splice(@A, $index);
  unshift @aux, $N;
  push @A, @aux;
}

# Output
say($index);
