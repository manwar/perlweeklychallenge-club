#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(zip);

sub sort_letters{
  my %h = map {$_->[0] => $_->[1]} zip $_[0],$_[1];
  join '',sort{$h{$a} <=> $h{$b}} keys %h
}

printf "%s\n",sort_letters(['R','E','P','L'],[3,2,1,4]);
printf "%s\n",sort_letters(['A','U','R','K'],[2,4,1,3]);
printf "%s\n",sort_letters(['O','H','Y','N','P','T'],[5,4,2,6,1,3]);

