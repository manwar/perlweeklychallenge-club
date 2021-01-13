#!/usr/bin/env perl
use strict;
use warnings;

my @sur=1..50;
my $i=0;
splice @sur, $i=($i+1)%@sur,1 while @sur > 1;
print "Survivor: $sur[0]\n"
