#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq all);

sub unique_occurences{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  my @values = values %h;
  @values == (uniq @values) || 0
}

printf "%d\n",unique_occurences([1,2,2,1,1,3]);
printf "%d\n",unique_occurences([1,2,3]);
printf "%d\n",unique_occurences([-2,0,1,-2,1,1,0,1,-2,9]);

