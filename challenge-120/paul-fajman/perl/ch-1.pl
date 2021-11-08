#!/usr/bin/perl

# Weekly Challenge 120 Task #1
# You are given a positive integer $N less than or equal to 255.
# Write a script to swap the odd positioned bit with even positioned 
# bit and print the decimal equivalent of the new binary representation.

use strict;
use warnings;

my $number = $ARGV[0];
my $binary = sprintf ('%b', $number);
my ($out1, $out2);
my $final;

# Determine if we have odd or even amount of binary digits
if (length($binary) % 2) {
  $binary = "0".$binary # Odd so add leading 0.
}

my @binary = split(//,$binary);
my $i;
my $new;

# Loop over the binary number to perform swap
for ($i=0; $i<$#binary+1; $i+=2) {
  $out1.= $binary[$i].$binary[$i+1]." ";
  $out2.= $binary[$i+1].$binary[$i]." ";
  $new.="$binary[$i+1]"."$binary[$i]";
}

$final = eval("0b".$new); # Convert back to decimal number
chomp($out1);
chomp($out2);

print "Input: \$N = $number\n";
print "Output: $final\n\n";

print "Binary representation of the given number is $out1\n";
print "The new binary representation after the odd/even swap is $out2\n";
print "The decimal equivalent of $new is $final\n";

