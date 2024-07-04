#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max sum0);

sub maximum_frequency{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  my $max = max values %h;
  sum0 grep {$_ if $_ == $max} values %h
}

printf "%d\n",maximum_frequency([1,2,2,4,1,5]);
printf "%d\n",maximum_frequency([1,2,3,4,5]);
