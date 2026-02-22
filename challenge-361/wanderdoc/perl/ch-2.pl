#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary matrix (m x n).

Write a script to find the celebrity, return -1 when none found.

    A celebrity is someone, everyone knows and knows nobody.

Example 1

Input: @party = (
            [0, 0, 0, 0, 1, 0],  # 0 knows 4
            [0, 0, 0, 0, 1, 0],  # 1 knows 4
            [0, 0, 0, 0, 1, 0],  # 2 knows 4
            [0, 0, 0, 0, 1, 0],  # 3 knows 4
            [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
            [0, 0, 0, 0, 1, 0],  # 5 knows 4
       );
Output: 4


Example 2

Input: @party = (
            [0, 1, 0, 0],  # 0 knows 1
            [0, 0, 1, 0],  # 1 knows 2
            [0, 0, 0, 1],  # 2 knows 3
            [1, 0, 0, 0]   # 3 knows 0
       );
Output: -1


Example 3

Input: @party = (
            [0, 0, 0, 0, 0],  # 0 knows NOBODY
            [1, 0, 0, 0, 0],  # 1 knows 0
            [1, 0, 0, 0, 0],  # 2 knows 0
            [1, 0, 0, 0, 0],  # 3 knows 0
            [1, 0, 0, 0, 0]   # 4 knows 0
       );
Output: 0


Example 4

Input: @party = (
            [0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
            [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
            [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
            [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
            [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
            [1, 0, 1, 1, 0, 0]   # 5 knows 0, 2, 3
       );
Output: 3


Example 5

Input: @party = (
            [0, 1, 1, 0],  # 0 knows 1 and 2
            [1, 0, 1, 0],  # 1 knows 0 and 2
            [0, 0, 0, 0],  # 2 knows NOBODY
            [0, 0, 0, 0]   # 3 knows NOBODY
       );
Output: -1


Example 6

Input: @party = (
            [0, 0, 1, 1],  # 0 knows 2 and 3
            [1, 0, 0, 0],  # 1 knows 0
            [1, 1, 0, 1],  # 2 knows 0, 1 and 3
            [1, 1, 0, 0]   # 3 knows 0 and 1
      );
Output: -1

=cut



use PDL; # Run with strawberry-perl-5.40.0.1-64bit-PDL
use Test2::V0 -no_srand => 1;

is(find_celebrity(  [0, 0, 0, 0, 1, 0],  # 0 knows 4
                    [0, 0, 0, 0, 1, 0],  # 1 knows 4
                    [0, 0, 0, 0, 1, 0],  # 2 knows 4
                    [0, 0, 0, 0, 1, 0],  # 3 knows 4
                    [0, 0, 0, 0, 0, 0],  # 4 knows NOBODY
                    [0, 0, 0, 0, 1, 0],  # 5 knows 4
), 4, 'Example 1');

is(find_celebrity(  [0, 1, 0, 0],  # 0 knows 1
                    [0, 0, 1, 0],  # 1 knows 2
                    [0, 0, 0, 1],  # 2 knows 3
                    [1, 0, 0, 0]   # 3 knows 0
), -1, 'Example 2');


is(find_celebrity(  [0, 0, 0, 0, 0],  # 0 knows NOBODY
                    [1, 0, 0, 0, 0],  # 1 knows 0
                    [1, 0, 0, 0, 0],  # 2 knows 0
                    [1, 0, 0, 0, 0],  # 3 knows 0
                    [1, 0, 0, 0, 0]   # 4 knows 0
), 0, 'Example 3');

is( find_celebrity([0, 1, 0, 1, 0, 1],  # 0 knows 1, 3, 5
               [1, 0, 1, 1, 0, 0],  # 1 knows 0, 2, 3
               [0, 0, 0, 1, 1, 0],  # 2 knows 3, 4
               [0, 0, 0, 0, 0, 0],  # 3 knows NOBODY
               [0, 1, 0, 1, 0, 0],  # 4 knows 1, 3
               [1, 0, 1, 1, 0, 0],   # 5 knows 0, 2, 3
            ), 3, 'Example 4');


is( find_celebrity( [0, 1, 1, 0],  # 0 knows 1 and 2
                    [1, 0, 1, 0],  # 1 knows 0 and 2
                    [0, 0, 0, 0],  # 2 knows NOBODY
                    [0, 0, 0, 0]   # 3 knows NOBODY
), -1, 'Example 5');            

is( find_celebrity( [0, 0, 1, 1],  # 0 knows 2 and 3
                    [1, 0, 0, 0],  # 1 knows 0
                    [1, 1, 0, 1],  # 2 knows 0, 1 and 3
                    [1, 1, 0, 0]   # 3 knows 0 and 1
), -1, 'Example 6');            

done_testing();

sub find_celebrity
{
     my @arr = @_;
     my $party = pdl(@arr);
     my $num_of_guests = $party->dim(1);
     my $idx_maybe_celebrity = which($party->sumover == 0); # ->at(0);
     if ( $idx_maybe_celebrity->isempty )
     {
          return -1;
     }
     else
     {
          my $candidate = $idx_maybe_celebrity->at(0);
          my $cand_col = $party->slice("$candidate, :");
          if (sum($cand_col) == $num_of_guests - 1)
          {
               return $candidate;
          }
          else
          {
               return -1;
          }
     }
}            
            
