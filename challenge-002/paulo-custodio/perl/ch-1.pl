#!/usr/bin/perl

# Challenge 002
#
# Challenge #1
# Write a script or one-liner to remove leading zeros from positive numbers.

use strict;
use warnings;
use 5.030;

my($N) = @ARGV;
$N =~ s/^0+(\d)/$1/;
say $N;
