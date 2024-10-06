#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(shuffle);

die "No file provided!\n" unless @ARGV == 1;

while(<>){
  s/(\w)(\w*)(\w)/$1.join '',shuffle split '',$2.$3/ge;
  print
}

