#!/usr/bin/env perl
use strict;
use warnings;

sub check_color{
  (ord(substr $_[0],0,1) + substr $_[0],1,1) % 2
}

printf "%d\n",check_color('d3');
printf "%d\n",check_color('g5');
printf "%d\n",check_color('e6');

