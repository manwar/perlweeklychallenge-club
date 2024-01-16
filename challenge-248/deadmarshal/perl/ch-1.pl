#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(indexes);
use List::Util qw(min);

sub shortest_distance{
  my @arr = split'',$_[0];
  map{my $i = $_; min map{abs $i - $_}indexes{$_ eq $_[1]}@arr}0..$#arr;
}

printf "(%s)\n",join ',',shortest_distance('loveleetcode','e');
printf "(%s)\n",join ',',shortest_distance('aaab','b');

