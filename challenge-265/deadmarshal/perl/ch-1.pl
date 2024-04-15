#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub thirty_three_percent_appearance{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  min grep{$h{$_} if $h{$_} >= (@{$_[0]}/3)}keys %h;
}

printf "%d\n",thirty_three_percent_appearance([1,2,3,3,3,3,4,2]);
printf "%d\n",thirty_three_percent_appearance([1,1]);
printf "%d\n",thirty_three_percent_appearance([1,2,3]);

