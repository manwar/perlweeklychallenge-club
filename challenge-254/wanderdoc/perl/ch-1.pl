#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer, $n. Write a script to return true if the given integer is a power of three otherwise return false.
Example 1 Input: $n = 27 Output: true 27 = 3 ^ 3
Example 2 Input: $n = 0 Output: false
Example 3 Input: $n = 6 Output: false
=cut






use Test2::V0;

sub is_power_of_N
{
     my ($num, $N) = @_;
     return 0 if ( $num < 1 );
     while ( $num % $N == 0 )
     {
          $num /= $N;
     }
     if ( 1 == $num )
     {
          return 1;
     }
     return 0;
}

is(is_power_of_N(27, 3), 1, 'Example 1');
is(is_power_of_N( 0, 3), 0, 'Example 2');
is(is_power_of_N( 6, 3), 0, 'Example 3');

done_testing();