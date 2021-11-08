#!/usr/bin/perl

# Weekly Challenge 120 Task #2
# You are given time $T in the format hh:mm.
# Write a script to find the smaller angle formed by the hands of an analog clock at a given time.

use strict;
use warnings;

my $input = $ARGV[0];
my $output;
my $angle; 
my @hand;

my @time = split(':',$input);

$hand[0]=30*$time[0]+($time[1]/60*30); # Calculate hour hand position. 
$hand[1]=$time[1]/60*360; # Calculate minute hand move
$angle = abs($hand[0] - $hand[1]); # Difference between angles

# We want the smallest of the angles. It must be less than or equal to 180.
if ($angle <= 180) {
  $output = $angle;
}
else {
  $output = abs(360-$angle);
}

print "Input: \$T = $input\n";
print "Output: $output\n";
