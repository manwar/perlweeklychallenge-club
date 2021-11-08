#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer $n >= 1. Write a script to find the $nth element of Ugly Numbers.
Ugly numbers are those number whose prime factors are 2, 3 or 5. For example, the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
Example
Input: $n = 7  Output: 8
Input: $n = 10 Output: 12
=cut







use List::Util qw(min);

my $N = shift or die "Number?$/";
my $idx2 = my $idx3 = my $idx5 = 1;
my @num;

my $i = 1;

$num[$i] = 1;

while ( $i < $N )
{
     my $last = $num[$i];
     $idx2++ while $num[$idx2] * 2 <= $last;
     $idx3++ while $num[$idx3] * 3 <= $last;
     $idx5++ while $num[$idx5] * 5 <= $last;
     $i++;
     $num[$i] = min($num[$idx2] * 2, $num[$idx3] * 3, $num[$idx5] * 5);
    
}


print $num[$i], $/;