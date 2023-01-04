#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(prime_count);

foreach(10,15,1,25){
  printf "%d\n", prime_count($_);
}

