#!/usr/bin/env perl
use strict;
use warnings;

sub last_member
{
  my ($arr) = @_;
  while(@$arr >= 2)
  {
    my ($f,$s) = @$arr;
    splice @$arr,0,2;
    unshift @$arr,$s-$f if($f != $s);
  }
  return scalar @$arr;
}

printf "%d\n", last_member([2,7,4,1,8,1]);
printf "%d\n", last_member([1]);
printf "%d\n", last_member([1,1]);

