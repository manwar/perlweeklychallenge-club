#!/usr/env/perl
# Task 1 Challenge 052 Solution by saiftynet
# Stepping Numbers
# Write a script to accept two numbers between 100 and 999. It should 
# then print all Stepping Numbers between them.
# A number is called a stepping number if the adjacent digits have 
# a difference of 1. For example, 456 is a stepping number but 129 
# is not.

# The challenge is relatively restricted that it only expects one
# to provide 3 digit stepping numbers.  This following solution extends
# the task to be able to provide every stepping number from 0-9,999,999
# So while the script will ask for two numbers, and will work perfectly
# well from numbers 100-999 as specified in the task, it will work for
# any inputs from 1 to 7 digits long 

# assembles an array of stepping numbers arranged by the number of digits
my @steppingNumbers;

# single digit numbers are just 1-9;
$steppingNumbers[1]=[(1..9)];

# subsequent arrays are assembled from the previous array
foreach my $digitCount (2..7){
  foreach my $no (@{$steppingNumbers[$digitCount-1]}){
    # get the last digit
    my $lastDigit=(split //,$no)[-1];
    # now continue adding digits one more or one less than the last digit
    # unless it will cause over or underflow
    push @{$steppingNumbers[$digitCount]},$no.($lastDigit-1)  if $lastDigit ne "0";
    push @{$steppingNumbers[$digitCount]},$no.($lastDigit+1)  if $lastDigit ne "9";
  }
}

# main program loop
print "Enter starting number >>"   and chomp (my $in1=<>);
print "Enter ending number >>"   and chomp (my $in2=<>);
# swaps numbers if entered in wrong order
($in1,$in2)=($in2,$in1)   if $in1>$in2;
foreach my $digits (length $in1..length $in2){
  foreach my $no (@{$steppingNumbers[$digits]}){
     print $no," " if $no>$in1 and $no < $in2;
  }
}
