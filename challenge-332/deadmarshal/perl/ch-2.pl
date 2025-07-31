#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub odd_letters{
  my %h;
  $h{$_}++ foreach split '',$_[0];
  all{$h{$_} & 1} keys %h
}

printf "%d\n",odd_letters('weekly');
printf "%d\n",odd_letters('perl');
printf "%d\n",odd_letters('challenge');

