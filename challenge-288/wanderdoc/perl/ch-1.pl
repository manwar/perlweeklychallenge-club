#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
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

use Test2::V0;




is(closest_palindrome(123),  121, 'Example 1');
is(closest_palindrome(2),      1, 'Example 2');
is(closest_palindrome(1440), 1441,'Example 3');
is(closest_palindrome(1001), 999, 'Example 4');
is(closest_palindrome(-123),  0,  'Example 5');
done_testing();


sub closest_palindrome
{
     my $num = $_[0];
     my @signs = ( -1, 1);
     my $multiplier = 1;
     
     my $cand = $num;
     do
     {
          for my $sign ( @signs )
          {
               $cand = $num + $multiplier * $sign;
               return $cand if is_palindrome($cand);
          }
          $multiplier++;
     } 
     while (1) 
}




sub is_palindrome
{
     return 0 if ( $_[0] < 0 );
     return $_[0] eq reverse($_[0]); 
}