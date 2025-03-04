#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str, made up of digits, and an integer, $int, which is greater than the length of the given string.

Write a script to divide the given string into consecutive groups of size $int (plus one for leftovers if any). Then sum the digits of each group, and concatenate all group sums to create a new string. If the length of the new string is less than or equal to the given integer then return the new string, otherwise continue the process.
Example 1

Input: $str = "111122333", $int = 3
Output: "359"

Step 1: "111", "122", "333" => "359"

Example 2

Input: $str = "1222312", $int = 2
Output: "76"

Step 1: "12", "22", "31", "2" => "3442"
Step 2: "34", "42" => "76"

Example 3

Input: $str = "100012121001", $int = 4
Output: "162"

Step 1: "1000", "1212", "1001" => "162"
=cut

use List::Util qw(sum reduce);
use Test2::V0 -no_srand => 1;

is(group_digit_sum("111122333", 3), 359, 'Example 1');
is(group_digit_sum("1222312", 2), 76, 'Example 2');
is(group_digit_sum("100012121001", 4), 162, 'Example 3');
done_testing();



sub group_digit_sum
{
     my $str = $_[0];
     my $int = $_[1];
     my $sum_str;
     LOOP:
     {
          $sum_str =
               reduce { $a . $b }
               map { sum(split(//,$_)) }
               unpack("(A" . $int . ')*', $str); 

          if ( length($sum_str) > $int )
          {
               $str = $sum_str;
               redo LOOP;
          }
     }
     return $sum_str;
}
