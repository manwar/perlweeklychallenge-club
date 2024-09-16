#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size of array, the digit i occurs exactly the $ints[$i] times in the given array otherwise return false.
Example 1

Input: @ints = (1, 2, 1, 0)
Ouput: true

$ints[0] = 1, the digit 0 occurs exactly 1 time.
$ints[1] = 2, the digit 1 occurs exactly 2 times.
$ints[2] = 1, the digit 2 occurs exactly 1 time.
$ints[3] = 0, the digit 3 occurs 0 time.

Example 2

Input: @ints = (0, 3, 0)
Ouput: false

$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
$ints[2] = 0, the digit 2 occurs exactly 0 time.
=cut

use constant { true => 1, false => 0 };
use Test2::V0;

is(digit_count_value(1, 2, 1, 0), true, 'Example 1');
is(digit_count_value(0, 3, 0), false, 'Example 2');
done_testing();

sub digit_count_value
{
     my @arr = @_;
     my %freq;
     $freq{$_}++ for @arr;
     for my $idx ( 0 .. $#arr )
     {
          if ( not exists $freq{$idx} )
          {
               $freq{$idx} = 0;
          }
          if ($arr[$idx] != $freq{$idx})
          {
               return false;
          }
     }
     return true;
}
