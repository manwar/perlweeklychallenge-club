#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub check_order{
  my @sorted = sort{$a <=> $b} @{$_[0]};
  map{$sorted[$_] != $_[0]->[$_] ? $_ : ()} 0..$#sorted
}

print show check_order([5,2,4,3,1]);
print show check_order([1,2,1,1,3]);
print show check_order([3,1,3,2,3]);

