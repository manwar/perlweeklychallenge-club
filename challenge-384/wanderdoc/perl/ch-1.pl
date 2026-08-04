#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number and a base integer.

Write a script to convert the given number in the given base integer.
Example 1

Input: $num = 42, $base = 2
Output: 101010

Example 2

Input: $num = 15642094, $base = 16
Output: EEADEE

Example 3

Input: $num = 493, $base = 8
Output: 755

Example 4

Input: $num = 2228519, $base = 36
Output: 1BRJB

Base 36 uses numbers 0-9 and letters A-Z.

Example 5

Input: $num = 123456789, $base = 64
Output: 7MyqL

Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)
=cut




use Test2::V0 -no_srand => 1;
is(base_N(42,2), '101010', 'Example 1');
is(base_N(15642094,16), 'EEADEE', 'Example 2');
is(base_N(493,8), '755', 'Example 3');
is(base_N(2228519,36), '1BRJB', 'Example 4');
is(base_N(123456789,64), '7MyqL', 'Example 5');
done_testing();

sub base_N
{
     my ($num, $base) = @_;
     return '0' if $num == 0;
     my @chars = ('0'..'9', 'A'..'Z', 'a' .. 'z', '+', '/');
     my $output = '';
     while ( $num > 0 )
     {
          my $rest = $num % $base;
          $output = $chars[$rest] . $output;
          $num = int($num/$base);
     }
     return $output;
}
