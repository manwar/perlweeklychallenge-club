#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive number $N.

Write a script to count the total numbrer of set bits of the binary representations of all numbers from 1 to $N and return $total_count_set_bit % 1000000007.

Example 1: Input: $N = 4 Total set bit count: 1 + 1 + 2 + 1 = 5
Output: Your script should print `5` as `5 % 1000000007 = 5`.


Example 2: Input: $N = 3 Total set bit count: 1 + 1 + 2 = 4
Output: Your script should print `4` as `4 % 1000000007 = 4`.

=cut
use Test::More;

sub count_set_bits
{
     my $num = $_[0];
     my $set_bits = 0;
     for my $i ( 1 .. $num )
     {

          my $binary = sprintf("%b", $i);
          $set_bits += $binary =~ tr/1/1/;
     }
     return $set_bits;
}
is(count_set_bits(4), 5, 'Example 1');
is(count_set_bits(3), 4, 'Example 2');

done_testing();