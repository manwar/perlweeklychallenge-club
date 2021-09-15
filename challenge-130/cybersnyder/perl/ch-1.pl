#!/usr/bin/env perl

use strict;
use warnings;

#my @N = ( 5, 7, 2, 3, 2, 3, 3, 3);
#my @N = (2, 5, 4, 4, 5, 5, 2);
#my @N = (1, 2, 3, 4, 3, 2, 1, 4, 4);
#my @N = (1);
#my @N = (1, 1);

my %count;
foreach (@N) { $count{$_}++; } 
foreach (keys %count) { ($count{$_} % 2) ? print "$_\n" : undef }

