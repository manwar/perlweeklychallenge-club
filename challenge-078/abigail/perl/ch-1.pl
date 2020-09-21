#!/opt/perl/bin/perl

#
# Exercise:
#    You are given an array @A containing distinct integers.
#    Write a script to find all leader elements in the array @A.
#    Print (0) if none found. An element is leader if it is greater
#    than all the elements to its right side.
#

#
# Note:
#    - The only way no leader element can be found is if the array is empty.
#    - We will read the array from STDIN.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';

my $max;

#
# Read the input, extract integers, and store them in @A.
# If the input is empty, print 0 and exit.
#
say (0), exit unless my @A = <> =~ /[0-9]+/g;

local $, = " ";

#
# Reverse the array, and extract each element which was larger
# than any seen before (keep state in $max), then reverse it
# again before printing.
#

say reverse
    grep {!defined $max || $_ > $max ? do {$max = $_; 1} : 0}
    reverse @A;
