#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub target_index{
  my @sorted = sort{$a <=> $b} @{$_[0]};
  map{$sorted[$_] == $_[1] ? $_ : ()}0..$#{$_[0]};
}

print show target_index([1,5,3,2,4,2],2);
print show target_index([1,2,4,3,5],6);
print show target_index([5,3,2,4,2,1],4);

