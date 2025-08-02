#!/usr/bin/env perl
use strict;
use warnings;

sub b_after_a{
  (-1 != index($_[0],'b')) >= rindex($_[0],'a')
}

printf "%d\n",b_after_a('aabb');
printf "%d\n",b_after_a('abab');
printf "%d\n",b_after_a('aaa');
printf "%d\n",b_after_a('bbb');

