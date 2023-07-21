#!/usr/bin/env perl
use strict;
use warnings;

sub shuffle_string
{
  my @ret;
  map{$ret[$_[1]->[$_]] = substr $_[0],$_,1} 0..$#{$_[1]};
  join '',@ret
}

printf "%s\n", shuffle_string('lacelengh',[3,2,0,5,4,8,6,7,1]);
printf "%s\n", shuffle_string('rulepark',[4,7,3,1,0,5,2,6]);

