#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string with English alphabetic characters only. What is the absolute difference of the sum of the ASCII values of the characters in the string to the nearest prime number?

Example 1
Input: $str = "hello"
Output: 9
The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
The nearest prime number to 532 is 523, resulting in an absolute difference of 9.

Example 2
Input: $str = "football"
Output: 2
Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
We find 839 as the nearest prime number, so the difference is 2.

Example 3
Input: $str = "a"
Output: 0

Example 4
Input: $str = "challenge"
Output: 2
The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
The nearest prime number to 931 is 929, so the difference is 2.
Example 5
Input: $str = "perl"
Output: 2
The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
Nearest prime is 433, so the difference is 2.
=cut

use ntheory qw(is_prime);
use List::Util qw(sum);
use Test2::V0 -no_srand => 1;


is(nearest_prime_diff_of_ascii_sum("hello"), 9, 'Example 1');
is(nearest_prime_diff_of_ascii_sum("football"), 2, 'Example 2');
is(nearest_prime_diff_of_ascii_sum("a"), 0, 'Example 3');
is(nearest_prime_diff_of_ascii_sum("challenge"), 2, 'Example 4');
is(nearest_prime_diff_of_ascii_sum("perl"), 2, 'Example 5');
done_testing();

sub nearest_prime_diff_of_ascii_sum
{
     my $str = $_[0];
     my $sum = sum(map ord($_), split(//,$str));
     my $offset = 0;
     return $offset if is_prime($sum);

     while ( 1 )
     {
          $offset++;

          my $output = $sum + $offset;
          return $offset if is_prime($output);
          $output = $sum - $offset;
          return $offset if is_prime($output);
     }
}
