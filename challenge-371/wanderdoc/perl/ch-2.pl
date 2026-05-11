#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of numbers.

Write a script to find all proper subsets with more than one element where the sum of elements equals the sum of their indices.
Example 1

Input: @nums = (2, 1, 4, 3)
Output: (2, 1), (1, 4), (4, 3), (2, 3)

Subset 1: (2, 1)
Values: 2 + 1 = 3
Positions: 1 + 2 = 3

Subset 2: (1, 4)
Values: 1 + 4 = 5
Positions: 2 + 3 = 5

Subset 3: (4, 3)
Values: 4 + 3 = 7
Positions: 3 + 4 = 7

Subset 4: (2, 3)
Values: 2 + 3 = 5
Positions: 1 + 4 = 5

Example 2

Input: @nums = (3, 0, 3, 0)
Output: (3, 0), (3, 0, 3)

Subset 1: (3, 0)
Values: 3 + 0 = 3
Positions: 1 + 2 = 3

Subset 2: (3, 0, 3)
Values: 3 + 0 + 3 = 6
Positions: 1 + 2 + 3 = 6

Example 3

Input: @nums = (5, 1, 1, 1)
Output: (5, 1, 1)

Subset 1: (5, 1, 1)
Values: 5 + 1 + 1 = 7
Positions: 1 + 2 + 4 = 7

Example 4

Input: @nums = (3, -1, 4, 2)
Output: (3, 2), (3, -1, 4)

Subset 1: (3, 2)
Values: 3 + 2 = 5
Positions: 1 + 4 = 5

Subset 2: (3, -1, 4)
Values: 3 + (-1) + 4 = 6
Positions: 1 + 2 + 3 = 6

Example 5

Input: @nums = (10, 20, 30, 40)
Output: ()
=cut


use List::Util qw(all sum);
use Test2::V0 -no_srand => 1;



is([count_subsets(2, 1, 4, 3)], [[2, 1], [1, 4], [2, 3], [4, 3]], 'Example 1');
is([count_subsets(3, 0, 3, 0)], [[3, 0], [3, 0, 3]], 'Example 2');
is([count_subsets(5, 1, 1, 1)], [[5, 1, 1]], 'Example 3');
is([count_subsets(3, -1, 4, 2)], [[3, -1, 4], [3, 2]], 'Example 4');
is([count_subsets(10, 20, 30, 40)], [], 'Example 5');
done_testing();

sub count_subsets
{
     my @nums = @_;
     my @output;
     return @output if all { $_ > scalar @nums } @nums;
     my $iterator = subsets([keys @nums]);
     while (my $subset = $iterator->()) 
     {
         next unless scalar @$subset > 1;
         next if scalar @$subset == scalar @nums; 
         my @positions = map $_ + 1, @$subset;
         next unless sum(@positions) == sum(@nums[@$subset]);
         push @output, [@nums[@$subset]];
     }
     return @output;
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
