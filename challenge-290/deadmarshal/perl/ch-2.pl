#!/usr/bin/env perl
use strict;
use warnings;

sub luhns_algorithm{
  my ($str) = @_;
  $str =~ tr/0-9//dc;
  my $p = chop $str;
  my ($sum,$even) = (0) x 2;
  foreach my $d(reverse split '',$str){
    $sum += $even ? $d : 2 * $d > 9 ? 2 * $d - 9 : 2 * $d;
    $even = !$even
  }
  ($sum + $p) % 10 == 0
}

printf "%d\n",luhns_algorithm('17893729974');
printf "%d\n",luhns_algorithm('4137 8947 1175 5904');
printf "%d\n",luhns_algorithm('4137 8974 1175 5904');

