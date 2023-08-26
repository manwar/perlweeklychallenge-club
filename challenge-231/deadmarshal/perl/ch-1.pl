#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);

sub min_max
{
  my ($arr) = @_;
  return "-1\n" if @$arr < 3;
  my ($min,$max) = (min(@$arr),max(@$arr));
  sprintf "(%s)\n", join ',', grep{$_ != $min && $_ != $max} @$arr;
}

print min_max([3,2,1,4]);
print min_max([3,1]);
print min_max([2,1,3]);

