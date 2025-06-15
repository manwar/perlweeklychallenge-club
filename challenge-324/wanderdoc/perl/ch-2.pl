#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.

Example 1

Input: @ints = (1, 3)
Output: 6

Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2

Sum of total XOR => 1 + 3 + 2 => 6


Example 2

Input: @ints = (5, 1, 6)
Output: 28

Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28


Example 3

Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480

=cut

use Test2::V0 -no_srand => 1;

is(total_xor(1, 3), 6, 'Example 1');
is(total_xor(5, 1, 6), 28, 'Example 2');
is(total_xor(3, 4, 5, 6, 7, 8), 480, 'Example 3');
done_testing();

sub total_xor
{
     my $iter = subsets(\@_);
     my $xor_sum = 0;
     while (my $p = $iter->()) 
     {
          next unless @$p;
          $xor_sum += eval join('^', @$p);
     }
     return $xor_sum;
}

sub subsets
{
    my $aref = $_[0];
    my $length = scalar @$aref;
    my $total = 2 ** $length; # Total number of subsets
    
    my $current = 0; # Start from the first bitmask
    
    return sub 
    {
          if ($current >= $total) 
          {
               return undef; # All subsets are generated
          }
        
          # Generate the current subset based on the bitmask
          my $bitmask = sprintf("%0${length}b", $current);
          my @bits = reverse split(//, $bitmask);
          my @included = grep { $bits[$_] == 1 } 0 .. $#bits;
        
          $current++; # Increment the bitmask
        
          return [@{$aref}[@included]]; # Return the subset
    };
}
