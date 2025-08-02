#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub maximum_ones{
  my $max = 0;
  map{my $c = sum0 @{$_[0]->[$_]}; $max = $_+1 if $c > $max} 0..$#{$_[0]};
  $max
}

printf "%d\n",maximum_ones([[0,1],[1,0]]);
printf "%d\n",maximum_ones([[0,0,0],[1,0,1]]);
printf "%d\n",maximum_ones([[0,0],[1,1],[0,0]]);

