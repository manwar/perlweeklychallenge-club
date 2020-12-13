#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two positive numbers $A and $B.
Write a script to demonstrate Ethiopian Multiplication using the given numbers.
https://threesixty360.wordpress.com/2009/06/09/ethiopian-multiplication/
=cut









use Test::More;
use Scalar::Util qw(looks_like_number);

sub em
{

     my ($num_1, $num_2) = @_;

     die "Two positive integers required!$/" 
          unless (looks_like_number($num_1) and looks_like_number($num_2) and
          $num_1 > 0 and $num_2 > 0 and 
          $num_1 = int($num_1) and $num_2 = int($num_2));
     return 0 if ($num_1 == 0 or $num_2 == 0);
     my $sum;
     while ( $num_1 > 0 )
     {
          if ( $num_1 % 2 )
          {
               $sum += $num_2;
          }


          $num_1 = int($num_1/2);
          $num_2 *= 2;
     }

     return $sum;
}



is(em(14, 12), 14 * 12, 'Example 1');
is(em(25,  5), 25 *  5, 'Example 2');
is(em(15, 30), 15 * 30, 'Example 3');


done_testing;