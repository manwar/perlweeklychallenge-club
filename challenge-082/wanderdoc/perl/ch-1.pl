#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given 2 positive numbers $M and $N. Write a script to list all common factors of the given numbers.
Example 1: Input: $M = 12 $N = 18 Output: (1, 2, 3, 6)
Example 2: Input: $M = 18 $N = 23 Output: (1)
=cut







print join(', ', common_factors(12, 18)), $/;
print join(', ', common_factors(18, 23)), $/;
print join(', ', common_factors(1810, 2020)), $/;
sub common_factors
{
     my ($num_1, $num_2) = @_;
     my $gcd = gcd($num_1, $num_2);
     my @factors;


     for my $i ( 1 .. $gcd )
     {
          push @factors, $i unless $gcd % $i;
     }
     return @factors;
}


sub gcd
{

     my ($num_1, $num_2) = @_;


          while ( $num_1 != $num_2 )
          {
               ($num_1, $num_2) = ($num_2, $num_1) if ($num_2 > $num_1);

               ($num_1, $num_2) = ($num_1 - $num_2, $num_2);
          }
     return $num_2;
}