#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(variations);
use List::Util qw(uniq);
use Data::Show;

sub three_digits_even{
  @{$_[0]} = sort{$a <=> $b} @{$_[0]};
  uniq map{join '',@$_} grep{$_->[0] && !($_->[2] % 2)}
    variations($_[0],3)
}

print show three_digits_even([2,1,3,0]);
print show three_digits_even([2,2,8,8,2]);

