#!/usr/bin/env raku

sub frequency-sort(@arr)
{
  my %h;
  %h{$_}++ for @arr;
  @arr.sort: {%h{$^a} <=> %h{$^b} || $^b <=> $^a};
}

say frequency-sort([1,1,2,2,2,3]);
say frequency-sort([2,3,1,3,2]);
say frequency-sort([-1,1,-6,4,5,-6,1,4,1]);

