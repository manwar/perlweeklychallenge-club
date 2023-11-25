#!/usr/bin/env perl
use strict;
use warnings;

sub count_smaller{
  my ($arr) = @_;
  map{my $e = $_;scalar grep{$_ < $e}@$arr}@$arr;
}

printf "(%s)\n",join ',',count_smaller([8,1,2,2,3]);
printf "(%s)\n",join ',',count_smaller([6,5,4,8]);
printf "(%s)\n",join ',',count_smaller([2,2,2]);

