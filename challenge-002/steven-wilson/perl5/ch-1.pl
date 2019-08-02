#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-04-03
# Challenge #1
# Write a script or one-liner to remove leading zeros from positive numbers.
#
# Usage: $ ./week2c1 0099

use warnings;
use strict;
use feature qw/ say /;

my ($number) = @ARGV;

$number =~ /[0]*(\d+)/;

say $1;
