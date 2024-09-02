#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub lucky_integer{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  max map{$h{$_} == $_ ? $_ : -1} keys %h
}

printf "%d\n",lucky_integer([2,2,3,4]);
printf "%d\n",lucky_integer([1,2,2,3,3,3]);
printf "%d\n",lucky_integer([1,1,1,3]);

