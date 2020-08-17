#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use Tie::IxHash;

# Iterate over the string in reverse order, dropping the last character each time.
# Use an order-preserving hash to record frequency counts, and pick the first one that
# is 1.

sub task2 {
  my @S = reverse split //, shift;
  my $res = "";
  while (@S) {
    tie my %counts, 'Tie::IxHash';
    for my $elem (@S) {
      $counts{$elem}++;
    }
    my $found = 0;
    while (my ($char, $count) = each %counts) {
      if ($count == 1) {
        $res .= $char;
        $found = 1;
        last;
      }
    }
    $res .= "#" unless $found;
    shift @S;
  }
  say scalar reverse $res;
}

task2 'ababc';
task2 'xyzzyx';
