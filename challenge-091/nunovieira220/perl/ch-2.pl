#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @A = (2, 1, 1, 0, 2);

# Jump Game
my $len = scalar @A;

if ($len <= 1) {
  say 1;
  exit;
}

my %targets = ($len - 1, 1);

for(my $i = $len - 2; $i > 0; $i--) {
  my $jump = $i + $A[$i];

  $targets{$i} = 1 if (defined $targets{$jump});
}

my $res = defined $targets{$A[0]} ? 1 : 0;

# Output
say $res;