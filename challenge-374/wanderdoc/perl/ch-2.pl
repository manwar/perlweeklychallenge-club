#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing 0-9 digits only.

Write a script to return the largest number with all digits the same in the given string.
Example 1

Input: $str = "6777133339"
Output: 3333

Example 2

Input: $str = "1200034"
Output: 4

Example 3

Input: $str = "44221155"
Output: 55

Example 4

Input: $str = "88888"
Output: 88888

Example 5

Input: $str = "11122233"
Output: 222
=cut

use Test2::V0 -no_srand => 1;





is(largest_same_digit_number(6777133339), 3333, 'Example 1');
is(largest_same_digit_number(1200034), 4, 'Example 2');
is(largest_same_digit_number(44221155), 55, 'Example 3');
is(largest_same_digit_number(88888), 88888, 'Example 4');
is(largest_same_digit_number(11122233), 222, 'Example 5');
done_testing();



sub largest_same_digit_number
{
     my $str = $_[0];
     my $max = 0;
     while ( $str =~ /(?<serie>(?<digit>[0-9])\k<digit>*)/g )
     {
          my $same_digit_number = $+{serie} + 0;
          $max = $same_digit_number > $max ? $same_digit_number : $max; 
     }
     return $max;
}
