#!/usr/env/perl
# Task 2 Challenge 061 Solution by saiftynet
# IPv4 Partition Reviewed by: Ryan Thompson
# You are given a string # containing only digits (0..9). The string
# should have between 4 and 12 digits.
# Write a script to print every possible valid IPv4 address that 
# can be made by partitioning the input string.
# For the purpose of this challenge, a valid IPv4 address consists 
# of four "octets"; i.e. A, B, C and D, separated by 
# dots (.).
# Each octet must be between 0 and 255, and must not have any leading 
# zeroes. (e.g., 0 is OK, but 01 is not.)
# Example
# Input: 25525511135,
# Output: 255.255.11.135, 255.255.111.35
use strict; use warnings;

ip4Partition($_) foreach (qw/25525511135 8888 127001 192168021/);

# subroutine works by partitioning trying all possible partitioning
# trying each possible positions for each of the three dots
# rejecting whenever partioning produces an invalid octet   

sub ip4Partition{
  my $input=shift;
  my $l=length $input;
  print "\nInput: $input yields the followng valid IP4 addresses:-\n";
  
  foreach my $firstDot(1..$l-3){                 # first dot     
    next      unless validOctet(substr($input,0,$firstDot)); 
      
    foreach my $secondDot($firstDot+1..$l-2){    # second dot   
      next    unless validOctet(substr($input,$firstDot,$secondDot-$firstDot));
      
      foreach my $thirdDot($secondDot+1..$l-1){  # third dot
         next unless (validOctet(substr($input,$secondDot,$thirdDot-$secondDot))
                  and validOctet(substr($input,$thirdDot, $l-$thirdDot)));
   
   # print the partitioned IP4 address                  
   print substr($input,0         ,$firstDot),            ".",
         substr($input,$firstDot ,$secondDot-$firstDot), ".",
         substr($input,$secondDot,$thirdDot-$secondDot), ".",
         substr($input,$thirdDot ,$l-$thirdDot),         " \n" ;}
    }
  }
  
  # validating an octet checks that the string is numeric, is less than 255
  # while it may be zero, does not otherwise have leading zeros
  sub validOctet{
    my $str=shift;
    return ($str=~/[\d]+/ and $str<=255 and $str!~/^0[\d]/)?1:0
    
  }
}

