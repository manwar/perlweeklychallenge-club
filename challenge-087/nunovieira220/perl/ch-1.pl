#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @N = (20, 19, 9, 11, 10);

# Longest Consecutive Sequence
my %nums = ();
my $res = -1;
my $counter = 1;

for (sort {$a <=> $b} @N) {
  if(defined $nums{$_ - 1}) {
    my $val = $nums{$_ - 1} + 1;
    $nums{$_} = $val;

    if ($val >= $counter) {
      $counter = $val;
      $res = $_;
    }
  } else {
    $nums{$_} = 1;
    $res = $_ if($counter == 1);
  }
}

# Output
say join(',', $res - $counter + 1..$res);