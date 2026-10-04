#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer n.

Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are integers <= n.
Example 1

Input: $n = 20
Output: 12

(3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
(8,6,10), (8,15,17), (9,12,15),(12,5,13),
(12,9,15),(12,16,20),(15,8,17),(16,12,20)

Example 2

Input: $n = 7
Output: 2

(3,4,5),(4,3,5)

Example 3

Input: $n = 1
Output: 0

Example 4

Input: $n = 15
Output: 8

Example 5
Input: $n = 30
Output: 22
=cut



use Test2::V0 -no_srand => 1;
is(count_pythagorean_triplets(20), 12, 'Example 1');
is(count_pythagorean_triplets(7),   2, 'Example 2');
is(count_pythagorean_triplets(1),   0, 'Example 3');
is(count_pythagorean_triplets(15),  8, 'Example 4');
is(count_pythagorean_triplets(30), 22, 'Example 5');
done_testing();

sub count_pythagorean_triplets
{
     my $n = $_[0];
     my %triplets;
     for my $m (2 .. int(sqrt($n)) + 1)
     {
          for my $k (1 .. $m - 1)
          {
               next if gcd($m, $k) > 1;
               my $side_a = $m * $m - $k * $k;
               my $side_b = 2 * $m * $k;
               my $side_c = $m * $m + $k * $k;
               
               for my $multiplier (1 .. int($n / $side_c))
               {
                    my ($x, $y, $z) = 
                         ($side_a * $multiplier, 
                          $side_b * $multiplier, 
                          $side_c * $multiplier);
                    last if $z > $n;
                    $triplets{"$x,$y,$z"} = undef;
                    $triplets{"$y,$x,$z"} = undef;
               }
          }
     }
     return scalar keys %triplets;
}


sub gcd
{
     my ($first, $second) = @_;
     while ( $second )
     {
          ($first, $second) = ($second, $first % $second);
     }
     return $first;
}
