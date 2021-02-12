#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $S = "littleit";
my $T = "lit";

# Output
say(counter($S, $T));

# Unique Subsequence
sub counter {
  my ($S, $T) = @_;

  return 0 if(!length($T) || !length($S));

  my $index = index($S, substr($T, 0, 1));
  my $last = length($T) == 1 ? 1 : 0;

  return 0 if($index == -1);
  return $last + counter(substr($S, $index + 1), $T) + counter(substr($S, $index + 1), substr($T, 1));
}
