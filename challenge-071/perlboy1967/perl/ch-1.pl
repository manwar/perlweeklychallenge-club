#!/usr/bin/perl

# Perl Weekly Challenge - 071
#
# Task 1 - Peak Element
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

my ($N) = @ARGV;

die "Argument must be a positive number ( 1 <= N <= 50)"
  unless (defined $N && $N =~ m#^[1-9][0-9]*$# and $N <= 50);

my @iPool = (1 .. 50);
my @array = map { splice(@iPool, int(rand(scalar(@iPool))), 1) } (1 .. $N);

my @peak = 
  map { $array[$_] } 
    grep { $array[$_] 
      if ($array[$_] > ($array[$_ + 1] // 0) and
          $array[$_] > ($array[$_ - 1] // 0));
    } (0 .. $N - 2); 

printf "Array: [%s]\n", join(', ', @array);
printf "Peak: [%s]\n", join(', ', @peak);
