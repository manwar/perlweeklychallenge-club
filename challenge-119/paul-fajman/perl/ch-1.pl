#/usr/bin/perl

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

