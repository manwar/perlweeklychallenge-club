#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given four squares as below with numbers named a,b,c,d,e,f,g.
Write a script to place the given unique numbers in the square box so that sum of numbers in each box is the same.
Box 1: a + b
Box 2: b + c + d
Box 3: d + e + f
Box 4: f + g
=cut






use Algorithm::Combinatorics qw (permutations);
use List::Util qw(sum);
use Scalar::Util qw(looks_like_number);

my @data = (-2, -1, 0, 1, 8, 9, 10); # 1 .. 7;
 


my $iter = permutations(\@data);
while (my $p = $iter->next) 
{
     my $test = test_sums(@$p);
     print join(":\t", $test, join('',('|', join('|',
          join(" ", @$p[0 .. 1]), join(" ", @$p[1 .. 3]),
          join(" ", @$p[3 .. 5]), join(" ", @$p[5 .. 6])), '|')) ), $/, $/ 
     if looks_like_number($test);
}





sub test_sums
{
     my @arr = @_;

     my $box1 = sum(@arr[0 .. 1]);
     my $box2 = sum(@arr[1 .. 3]);
     my $box3 = sum(@arr[3 .. 5]);
     my $box4 = sum(@arr[5 .. 6]);

     if ( $box1 == $box2 and $box1 == $box3 and $box1 == $box4 )
     {
          return $box1;
     }
     return 'Nope';
}