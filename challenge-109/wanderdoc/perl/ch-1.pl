#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate first 20 Chowla Numbers, named after, Sarvadaman D. S. Chowla, a London born Indian American mathematician. It is defined as: C(n) = (sum of divisors of n) - 1 - n
Output: 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21
=cut






use Test::More;

sub chowla_num
{
     my $num = $_[0];
     my $div_sum = div_sum($num);
     my $chowla_num = $num == 1 ? ($div_sum - 1) : ($div_sum - 1 - $num);
     return $chowla_num;
}



sub div_sum
{
     my $num = $_[0];
     my $sum = 0; 
     return $num if $num < 2;
     for my $i ( 1 .. $num )
     {
          $sum += $i if ( $num % $i == 0 )
     }
     return $sum;
}



my @output;



for my $n ( 1 .. 78 )
{
     push @output, chowla_num($n);
}

is_deeply([@output], [0,0,0,2,0,5,0,6,3,7,0,15,0,9,8,14,0,20,0,21,10,13,0,35,5,15,12,27,0,41,0,30,14,19,12,54,0,21,16,
 49,0,53,0,39,32,25,0,75,7,42,20,45,0,65,16,63,22,31,0,107,0,33,40,62,18,77,0,57,26,73,0,122,0,39,48,63,18,89], 'A048050');
done_testing();