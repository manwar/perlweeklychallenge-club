#!/usr/bin/env raku

use v6.d;
use Test;

plan 3;

is-deeply <3 1 1 2 2 2>, frequency-sort <1 1 2 2 2 3>;
is-deeply <1 3 3 2 2>, frequency-sort <1 2 2 3 3>;
is-deeply <5 -1 4 4 -6 -6 1 1 1>, frequency-sort <-1 1 -6 4 5 -6 1 4 1>;

sub frequency-sort(@_) { 
  my $frequencies = @_.Bag;
  @_.sort: { $frequencies{$^a} <=> $frequencies{$^b} || $^b <=> $^a }
}