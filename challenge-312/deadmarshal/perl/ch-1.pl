#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub minimum_time{
  my ($str) = @_;
  my ($res,$prev) = (0,0);
  foreach my $c(split '',$str){
    my $curr = ord($c) - ord('a');
    my $t = abs($prev - $curr);
    $t = min($t,26-$t);
    $res += $t+1;
    $prev = $curr
  }
  $res
}

printf "%d\n",minimum_time('abc');
printf "%d\n",minimum_time('bza');
printf "%d\n",minimum_time('zjpc');

