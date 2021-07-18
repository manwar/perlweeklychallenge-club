#!/usr/bin/env perl
#
use 5.032;
use warnings;
use strict;

# You are given integers 0 <= $m <= 255 and 1 <= $n <= 8. Write a script to invert $n bit from the end of the binary representation of $m and print the decimal representation of the new binary number.
#
# Here implemented as command line options. Because it's easy.
#

my $m = shift or die "Need more numbers.";
my $n = shift or die "Need more numbers.";
if (($m > 255) || ($m < 0)) {die "Not in range 0 - 255."}
if (($n > 8) || ($n < 1)) {die "Not in range 1 - 8."}

my $Mask = 1;
$Mask = ($Mask<<($n-1));
my $Result = ($Mask ^ $m);

say "New binary number is: $Result";
