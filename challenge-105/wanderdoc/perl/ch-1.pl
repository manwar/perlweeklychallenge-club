#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given positive numbers $N and $k. Write a script to find out the $Nth root of $k.
Example
Input: $N = 5, $k = 248832 Output: 12
Input: $N = 5, $k = 34 Output: 2.02
=cut







use Test::More;
use List::Util qw(reduce);

sub nthroot # newton algorithm
{
     my ( $n, $k, $precision ) = @_;

     $precision //= 5;

     my $x0 = $k / $n;
     my $x1; 
          
     while (1)
     {
          $x1 = (1 / $n) * 
               ( ( $n - 1 ) * $x0 + $k / ( reduce { $a * $b } ($x0) x ($n - 1) ) );
          last if sprintf("%.${precision}f", $x0) == sprintf("%.${precision}f", $x1);
          $x0 = $x1;
     }
     return sprintf("%.${precision}f", $x1) + 0;
}


is(nthroot(5, 248832), 12,  'Example 1');
is(nthroot(5, 34, 2), 2.02, 'Example 2');
is(nthroot(2, 2, 8), 1.41421356, 'Example 3'); 
is(nthroot(5, 222), 2.94626, 'Example 4');
is(nthroot(123, 987), 1.05766, 'Example 5');
done_testing();