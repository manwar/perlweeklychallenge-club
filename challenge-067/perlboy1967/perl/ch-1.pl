#!/usr/bin/perl

# Perl Weekly Challenge - 067
#
# Task 1 - Number combinations
#
# Author: Niels 'PerlBoy' van Dijke
#
# Comments: Fun with 'glob()' #1 (Not scalable though ;-) )

use strict;
use warnings;

use List::MoreUtils qw(uniq);

my ($m, $n);

if (scalar @ARGV >=2) {
  ($m, $n) = @ARGV;
} else {
  ($m, $n) = (5, 2);
}

die "M must be bigger or equal to N (M=$m, N=$n)"
  unless ($m >= $n);

my @list = grep {
  my @d = split(/,/); 
  join('',@d) eq join('',uniq sort @d)
} glob('{'.join('},{', (join(',', 1 .. $m)) x $n).'}');

printf "Input: m = %d, n = %d\n", $m, $n;
printf "Output: [ [%s] ]\n", join("], [", @list);

