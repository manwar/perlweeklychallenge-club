#!/usr/bin/env perl
use strict;
use warnings;
use v5.012;

my @out=([1],[1,1]);

for (3..$ARGV[0]) {
  my @new_row=(1,@{$out[-1]});
  for (1..$#{$out[-1]}) {
    $new_row[$_] = $out[-1][$_-1] + $out[-1][$_];
  }
  push @out, \@new_row;
}

# format data for output - obviously you'll run out of terminal at some point,
# so, this is just a pretty demo output
my $longest_length = length("@{$out[-1]}");
for (0..$#out) {
  $out[$_] = "@{$out[$_]}";
  my $this_length = length($out[$_]);
  say ' 'x(($longest_length-$this_length)/2).$out[$_];
}
