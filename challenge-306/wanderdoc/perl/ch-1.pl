#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of the given array. A subarray is a contiguous subsequence of the array.
Example 1

Input: @ints = (2, 5, 3, 6, 4)
Output: 77

Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20

Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example 2

Input: @ints = (1, 3)
Output: 4
=cut

use List::Util qw(sum);
use Test2::V0 -no_srand => 1;

is(odd_sum(2, 5, 3, 6, 4), 77, 'Example 1');
is(odd_sum(1, 3), 4, 'Example 2');
done_testing();


sub odd_sum
{
     my @arr = @_;
     my $iterator = odd_contig_subsets([@arr]);
     my $sum;
     while (my $subset = $iterator->()) 
     {
         $sum += sum(@$subset);
     }
     return $sum;
}

sub odd_contig_subsets
{
     my $aref = $_[0];
     my $length = scalar @$aref;
     my $total = 2 ** $length; # Total number of subsets
     
     my $current = 1; # Start from the first bitmask excluding 0
    
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
        
          # now instead of just $current++ choose odd contiguous subsets:
          my $count; 
          do {
               $current++;
               $bitmask = sprintf("%0${length}b", $current);
               $count = $bitmask =~ tr/1/1/; 
          }
          while ( $count % 2 == 0 or $bitmask =~ /10+1/ );

          return [@{$aref}[@included]]; # Return the subset
     };
}