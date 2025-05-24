#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq);
use Data::Show;

sub rank_array{
  my @uniq = sort{$a <=> $b} uniq @{$_[0]};
  my %h;
  @h{@uniq} = 1..@uniq;
  @h{@{$_[0]}}
}

print show rank_array([55,22,44,33]);
print show rank_array([10,10,10]);
print show rank_array([5,1,1,4,3]);

