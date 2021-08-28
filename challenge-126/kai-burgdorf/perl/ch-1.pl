#!/usr/bin/env perl

use utf8;
use strict;
use warnings;


my $N = 25;
my $count = 0;

for(2..$N) { $count++ if ( "$_" !~ m/1/ ); }
print "Input: $N\nOutput:\n\t$count\n";
