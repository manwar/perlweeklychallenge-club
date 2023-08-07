#!/usr/bin/env raku

sub unique-sum(@arr)
{
  my %hash;
  %hash{$_}++ for @arr;
  %hash.keys.grep({%hash{$_} == 1}).sum
}

say unique-sum([2,1,3,2]);
say unique-sum([1,1,1,1]);
say unique-sum([2,1,3,4]);

