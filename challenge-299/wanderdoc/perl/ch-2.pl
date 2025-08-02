#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a grid of characters and a string.

Write a script to determine whether the given string can be found in the given grid of characters. You may start anywhere and take any orthogonal path, but may not reuse a grid cell.
Example 1

Input: @chars = (['A', 'B', 'D', 'E'],
                 ['C', 'B', 'C', 'A'],
                 ['B', 'A', 'A', 'D'],
                 ['D', 'B', 'B', 'C'])
      $str = 'BDCA'
Output: true

Example 2

Input: @chars = (['A', 'A', 'B', 'B'],
                 ['C', 'C', 'B', 'A'],
                 ['C', 'A', 'A', 'A'],
                 ['B', 'B', 'B', 'B'])
      $str = 'ABAC'
Output: false

Example 3

Input: @chars = (['B', 'A', 'B', 'A'],
                 ['C', 'C', 'C', 'C'],
                 ['A', 'B', 'A', 'B'],
                 ['B', 'B', 'A', 'A'])
      $str = 'CCCAA'
Output: true
=cut

use List::MoreUtils qw(indexes);
use constant {true => 1, false => 0};


use Test2::V0 -no_srand => 1;


is( word_search([['A', 'B', 'D', 'E'],
                 ['C', 'B', 'C', 'A'],
                 ['B', 'A', 'A', 'D'],
                 ['D', 'B', 'B', 'C']], 'BDCA'), true, 'Example 1');
is( word_search([['A', 'A', 'B', 'B'],
                 ['C', 'C', 'B', 'A'],
                 ['C', 'A', 'A', 'A'],
                 ['B', 'B', 'B', 'B']], 'ABAC'), false, 'Example 2');
is( word_search([['B', 'A', 'B', 'A'],
                 ['C', 'C', 'C', 'C'],
                 ['A', 'B', 'A', 'B'],
                 ['B', 'B', 'A', 'A']], 'CCCAA'), true, 'Example 3'); 

done_testing();
                 



sub word_search 
{
     my ($grid, $string) = @_;
     my $height = $#$grid;
     my $breadth = $#{$grid->[0]};
     my $string_length = length($string);

     return false if $string_length > (($height + 1) * ($breadth + 1));

     for my $i (0 .. $height) 
     {
          for my $j (0 .. $breadth) 
          {
               if ($grid->[$i][$j] eq substr($string, 0, 1)) 
               {
                    my @stack = ([$i, $j, 0, { "$i|$j" => 1 }]); # (row, col, index, visited)

                    while (@stack) 
                    {
                         my ($this_i, $this_j, $current_index, $vis_ref) = @{pop @stack};
                         return true if ($current_index == $string_length - 1);

                         for my $dir ([0, 1], [0, -1], [1, 0], [-1, 0]) 
                         {
                              my $next_i = $this_i + $dir->[0];
                              my $next_j = $this_j + $dir->[1];

                              if ($next_i >= 0 and $next_i <= $height and
                              $next_j >= 0 and $next_j <= $breadth and
                              not exists $vis_ref->{"$next_i|$next_j"} and
                              $grid->[$next_i][$next_j] eq 
                                   substr($string, $current_index + 1, 1)) 
                              {
                                   my %next_visited = %{$vis_ref};
                                   $next_visited{"$next_i|$next_j"} = 1;
                                   push @stack, 
                                        [$next_i, $next_j, 
                                        $current_index + 1, \%next_visited];
                              }
                         }
                    }
               }
          }
     }
     return false;
}
