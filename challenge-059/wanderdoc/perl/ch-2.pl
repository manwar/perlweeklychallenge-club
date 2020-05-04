#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
For this task, you will most likely need a function f(a,b) which returns the count of different bits of binary representation of a and b.
For example, f(1,3) = 1, since:
Binary representation of 1 = 01
Binary representation of 3 = 11

There is only 1 different bit. Therefore the subroutine should return 1. Note that if one number is longer than the other in binary, the most significant bits of the smaller number are padded (i.e., they are assumed to be zeroes).
Script Output

You script should accept n positive numbers. Your script should sum the result of f(a,b) for every pair of numbers given:
For example, given 2, 3, 4, the output would be 6, since f(2,3) + f(2,4) + f(3,4) = 1 + 2 + 3 = 6

=cut

use List::Util qw(max);

sub pairwise_difbits
{
     my ($n1, $n2) = @_;
     my $max = max(map length(sprintf("%b", $_)), ($n1, $n2));
     ($n1, $n2) =  map sprintf("%0${max}b", $_) , ($n1, $n2);

     my $count = 0;
     for my $i ( 0 .. $max - 1 )
     {
          $count++ if substr($n1, $i, 1) != substr($n2, $i, 1);
     }
     return $count;  
}

sub sumdif
{
     my @numbers = @_;
     my $sum;


     for my $i ( 0 .. $#numbers - 1 )
     {
          for my $j ( $i .. $#numbers )
          {
               next if $i == $j;
               $sum += pairwise_difbits(@numbers[$i, $j]);
          }
     }

     return $sum;
}

print sumdif ( 1, 2, 3, 4, 5 ), $/;