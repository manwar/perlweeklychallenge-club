#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N. Write a script to sum GCD of all possible unique pairs between 1 and $N.
Example 1: Input: 3 Output: 3 (gcd(1,2) + gcd(1,3) + gcd(2,3))
Example 2: Input: 4 Output: 7 (gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4))

=cut






use Algorithm::Combinatorics qw(combinations);
use Test::More;

sub sum_gcd
{
     my $n = $_[0];
     return 1 if $n == 1;
     
     die "Positive integer needed!$/" if ( $n < 1 or $n != int($n));

     my $sum = 0;
     my $iter = combinations([1 .. $n], 2);
     while (my $p = $iter->next)
     {
          $sum += gcd(@$p);
     }
     return $sum;
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

is(sum_gcd(3), 3, 'Example 1');
is(sum_gcd(4), 7, 'Example 2');
done_testing();