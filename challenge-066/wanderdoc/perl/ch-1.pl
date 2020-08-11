#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two integers $M and $N.

Write a script to divide the given two integers i.e. $M / $N without using multiplication, division and mod operator and return the floor of the result of the division.
Example 1:

Input: $M = 5, $N = 2
Output: 2

Example 2:

Input: $M = -5, $N = 2
Output: -2

Example 3:

Input: $M = -5, $N = -2
Output: 2

=cut
use Test::More;

sub floor_division
{
     my ($m, $n) = @_;
     die "Division by 0$/" if 0 == $n;
     return 0 if 0 == $m;
     
     my $sign = 1;
     if ( $m < 0 ) { $sign = 0 - $sign; }
     if ( $n < 0 ) { $sign = 0 - $sign; }
     
     $m = abs($m);
     $n = abs($n);


     my $counter = 0;
     while ( $m > $n )
     {

          $m -= $n;
          $counter++;
     }
     return 1 == $sign ? $counter : 0 - $counter;

}

is(floor_division( 5,  2),  2, ' 5 /  2');
is(floor_division(-5,  2), -2, '-5 /  2');
is(floor_division(-5, -2),  2, '-5 / -2');
is(floor_division(10,  3),  3, '10 /  3');
is(floor_division(17, -2), -8, '17 / -2');


done_testing();