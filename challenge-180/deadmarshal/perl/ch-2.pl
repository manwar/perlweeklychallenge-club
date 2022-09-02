#!/usr/bin/env perl
use strict;
use warnings;

sub trim_list{
  my ($arr, $i) = @_;
  grep {$_ > $i} @$arr;
}

my ($n, $i) = ([1,4,2,3,5], 3);
my ($n2, $i2) = ([9,0,6,2,3,8,5], 4);
printf "(%s)\n" => join ',' => trim_list($n, $i);
printf "(%s)\n" => join ',' => trim_list($n2, $i2);
