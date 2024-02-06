#!/usr/bin/env perl
use strict;
use warnings;

sub three_power{
  $_[0] == int($_[0]**(1/3))**3
}

printf "%d\n",three_power(27);
printf "%d\n",three_power(0);
printf "%d\n",three_power(6);

