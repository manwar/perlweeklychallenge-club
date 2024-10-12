=begin
You are given a string, $str, which is an integer.

Write a script to find out the closest palindrome, not including itself. If there are more than one then return the smallest.

The closest is defined as the absolute difference minimized between two integers.

Example 1
Input: $str = "123"
Output: "121"
Example 2
Input: $str = "2"
Output: "1"

There are two closest palindrome "1" and "3". Therefore we return the smallest "1".
Example 3
Input: $str = "1400"
Output: "1441"
Example 4
Input: $str = "1001"
Output: "999"
=cut


use strict;
use warnings;

my @input = (4,11,66,123,2,1400,1001);

foreach(@input){
  print "-> $_: ";
  my $result = findClosestPalindrome($_);
  print "Palindrome: $result \n";
}

sub check_palindrome {
    my $mid = length $_[0] / 2;
    return ($mid == 0 or substr($_[0], 0, $mid) eq scalar reverse substr($_[0], -$mid));
}

sub findClosestPalindrome {
  
  my ($smallest, $highest) = ($_[0] - 1, $_[0] + 1);
    --$smallest until check_palindrome($smallest);
    ++$highest until check_palindrome($highest);
    return $highest - $_[0] < $_[0] - $smallest ? $highest : $smallest;

}
