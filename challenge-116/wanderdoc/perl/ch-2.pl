#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number $N >= 10. Write a script to find out if the given number $N is such that sum of squares of all digits is a perfect square. Print 1 if it is otherwise 0.
Example
Input: $N = 34 Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
Input: $N = 50 Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
Input: $N = 52 Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
=cut





use List::Util qw(sum);

sub is_perfect_square
{
     my $num = $_[0];
     my $square_root = sqrt($num);
     return $square_root == int($square_root) ? 1 : 0;
}


sub sum_of_squares
{
     my $int = $_[0];
     my @digits = split(//,$int);
     my $sum_of_squares = sum(map $_ * $_, @digits);
     return $sum_of_squares;
}

for my $num ( 34, 50, 52, 679, 5311 )
{
     print $num, ': ', is_perfect_square(sum_of_squares($num)), $/;
}