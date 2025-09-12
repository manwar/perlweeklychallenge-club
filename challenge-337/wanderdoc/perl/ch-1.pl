#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of numbers, @num1.
Write a script to return an array, @num2, where $num2[i] is the count of all numbers less than or equal to $num1[i].

Example 1

Input: @num1 = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

index 0: numbers <= 6 are 5, 4    => 2
index 1: numbers <= 5 are 4       => 1
index 2: numbers <= 4, none       => 0
index 3: numbers <= 8 are 6, 5, 4 => 3


Example 2

Input: @num1 = (7, 7, 7, 7)
Output: (3, 3, 3, 3)


Example 3

Input: @num1 = (5, 4, 3, 2, 1)
Output: (4, 3, 2, 1, 0)


Example 4

Input: @num1 = (-1, 0, 3, -2, 1)
Output: (1, 2, 4, 0, 3)


Example 5

Input: @num1 = (0, 1, 1, 2, 0)
Output: (1, 3, 3, 4, 1)

=cut






use List::Util qw(max);
use Test2::V0 -no_srand => 1;

is([smaller_or_equal_than_current(6, 5, 4, 8)], [2, 1, 0, 3], 'Example 1');
is([smaller_or_equal_than_current(7, 7, 7, 7)], [3, 3, 3, 3], 'Example 2');
is([smaller_or_equal_than_current(5, 4, 3, 2, 1)], [4, 3, 2, 1, 0], 'Example 3');
is([smaller_or_equal_than_current(-1, 0, 3, -2, 1)], [1, 2, 4, 0, 3], 'Example 4');
is([smaller_or_equal_than_current(0, 1, 1, 2, 0)], [1, 3, 3, 4, 1], 'Example 5');


done_testing();

sub smaller_or_equal_than_current
{
     my @arr = @_;
     my %count;
     my $level = scalar(@arr) - 1;
     my $previous;
     my $equals = 0;
     for my $num ( sort {$b <=> $a} @arr ) # keys %idx )
     {
          if ( (defined $previous) and ($num < $previous))
          {
               $level -= max(1, $equals);
               $equals = 1; # 0
          }
          else
          {
               $equals++;
          }
          $count{$num} = $level;
          $previous = $num;
     }
     return @count{@arr};
}
