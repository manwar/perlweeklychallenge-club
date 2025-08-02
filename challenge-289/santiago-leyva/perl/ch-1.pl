=begin
You are given an array of integers, @ints.

Write a script to find the third distinct maximum in the given array. If third maximum doesn’t exist then return the maximum number.

Example 1
Input: @ints = (5, 6, 4, 1)
Output: 4

The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.
Example 2
Input: @ints = (4, 5)
Output: 5

In the given array, the third maximum doesn't exist therefore returns the maximum.
Example 3
Input: @ints =  (1, 2, 2, 3)
Output: 1

The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.
=cut

use strict;

use Test::More tests => 3;

sub findThirdMaximum {
  my $arr = shift;
  my @A = @$arr;

  my %set = map { $_ => 1} @A;

  my @nums = sort {$a <=> $b} keys %set;

  if(scalar @nums < 3){
    return $nums[-1];
  }else{
    return $nums[-3];
  }
}

my @example1 = (5, 6, 4, 1);
my @example2 = (4, 5);
my @example3 = (1, 2, 2, 3);

is(findThirdMaximum(\@example1),4);
is(findThirdMaximum(\@example2),5);
is(findThirdMaximum(\@example3),1);