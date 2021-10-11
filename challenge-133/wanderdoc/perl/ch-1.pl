#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N. Write a script to calculate the integer square root of the given number $N. Please avoid using built-in function.
=cut







use List::Util qw(reduce);



sub nthroot # newton algorithm ch.105
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
sub int_sqrt { return nthroot(2, $_[0], 0) }



print int_sqrt(10), $/;
print int_sqrt(27), $/;
print int_sqrt(85), $/;
print int_sqrt(101), $/;
print int_sqrt(333), $/;