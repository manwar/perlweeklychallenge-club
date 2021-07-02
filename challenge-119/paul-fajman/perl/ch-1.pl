#/usr/bin/perl

# Weekly Challenge 119
# You are given a positive integer $N.
# Write a script to swap the two nibbles of the binary representation of the 
# given number and print the decimal number of the new binary representation.
#
# Input: $N = 101
# Output: 86

# Binary representation of decimal 101 is 1100101 or as 2 nibbles (0110)(0101).
# The swapped nibbles would be (0101)(0110) same as decimal 86.

# Input: $N = 18
# Output: 33

# Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
# The swapped nibbles would be (0010)(0001) same as decimal 33.
##############################

use strict;
use warnings;

use POSIX;

my $int = $ARGV[0];
my $quo = $int;
my ($i, $rem);
my $total = 0;
my @nibbles=();

# Calculate binary number
while($quo ne 0) {
  $rem = floor($quo % 2);
  unshift @nibbles, $rem;
  $quo = floor($quo/2);
}

# Check that final number is 8 digits
while ($#nibbles+1 lt 8) {
  unshift @nibbles, 0;
}

# Swap the nibbles
my @final = splice(@nibbles, 4);
@final = (@final, @nibbles);

# Calcuate the new decimal number
for ($i=7; $i>-1; $i--) {
  $total+= $final[$i]*(2**(7-$i));
}

print "Input: \$N = $int\n";
print "Output: $total\n";

