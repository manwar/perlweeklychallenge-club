#!/usr/bin/perl

# Perl Weekly Challenge - 071
#
# Task 1 - Peak Element
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

my ($N) = @ARGV;

die "Argument must be a positive number bigger then 1"
  unless (defined $N && $N =~ m#^[2-9][0-9]*#);

my @array = map { int(rand(50) + 0.5) } (1 .. $N);

my @peak = 
  map { $array[$_] } 
    grep { $array[$_] 
      if ($array[$_] > ($array[$_ + 1] // 0));
    } (0 .. $N - 2); 

printf "Array: [%s]\n", join(', ', @array);
printf "Peak: [%s]\n", join(', ', @peak);
