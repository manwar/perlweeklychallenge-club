#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $str containing digits (and possibly other characters which can be ignored). The last digit is the payload; consider it separately. Counting from the right, double the value of the first, third, etc. of the remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on reddit.
Example 1

Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 19
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 19
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.

Example 2

Input: "4137 8947 1175 5904"
Output: true

Example 3

Input: "4137 8974 1175 5904"
Output: false
=cut




use constant {true => 1, false => 0};
use Test2::V0;

is(Luhn_Algorithm('1789 3729 974'), true, 'Example 1');
is(Luhn_Algorithm('4137 8947 1175 5904'), true, 'Example 2');
is(Luhn_Algorithm('4137 8974 1175 5904'), false, 'Example 3');
done_testing();

sub Luhn_Algorithm
{
     my $str = $_[0];
     $str =~ s/[^0-9]//g;
     my $sum = 0;
     my $flag = 1;

     IDX: for my $idx ( reverse 0 .. length($str) - 2 )
     {
          my $num = substr($str, $idx, 1);

          if ( $flag == 1 )
          {
               $num *= 2;
               if ( $num > 9 )
               {
                    $num-= 9;
               }
               $sum += $num;
               $flag = 0;
               next IDX;
          }
          else
          {
               $sum += $num;
               $flag = 1;
          }
     }
     $sum += substr($str, -1, 1);
     return $sum % 10 == 0 ? true : false ;
}