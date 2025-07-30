#!/usr/bin/env perl
use strict;
use warnings;

sub binary_date{
  $_[0] =~ s/(\d+)/{sprintf "%b",$1}/rge
}

printf "%s\n",binary_date('2025-07-26');
printf "%s\n",binary_date('2000-02-02');
printf "%s\n",binary_date('2024-12-31');

