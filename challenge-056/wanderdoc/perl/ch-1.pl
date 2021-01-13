#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array @N of positive integers (sorted) and another non negative integer k.
Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.
It should print the pairs of indices, if any such pairs exist.
Example:
	@N = (2, 7, 9) 
	$k = 2
Output : 2,1

=cut


my @N = (0 .. 9); # (2, 7, 9);
my $k = shift || 2;

for my $j ( 0 .. $#N )
{
     for my $i ( $j .. $#N )
     {
          next if $i == $j;
          print join(", ", $i, $j), $/ if $k == $N[$i] - $N[$j];

     }
}