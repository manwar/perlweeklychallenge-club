#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a n x n matrix containing integers from 1 to n. Write a script to find if every row and every column contains all the integers from 1 to n.
Example 1
Input: @matrix = ([1, 2, 3, 4],
                  [2, 3, 4, 1],
                  [3, 4, 1, 2],
                  [4, 1, 2, 3],)
Output: true

Example 2

Input: @matrix = ([1])
Output: true

Example 3

Input: @matrix = ([1, 2, 5],
                  [5, 1, 2],
                  [2, 5, 1],)
Output: false

Elements are out of range 1..3.

Example 4

Input: @matrix = ([1, 2, 3],
                  [1, 2, 3],
                  [1, 2, 3],)
Output: false

Example 5

Input: @matrix = ([1, 2, 3],
                  [3, 1, 2],
                  [3, 2, 1],)
Output: false
=cut


use constant { true => 1, false => 0 };





use Test2::V0 -no_srand => 1;
is(same_row_column([[1, 2, 3, 4], [2, 3, 4, 1],
                  [3, 4, 1, 2], [4, 1, 2, 3]]), false, 'Example 1');
is(same_row_column([[1]]), true, 'Example 2');
is(same_row_column([[1, 2, 5], [5, 1, 2], [2, 5, 1]]), false, 'Example 3');
is(same_row_column([[1, 2, 3], [1, 2, 3], [1, 2, 3]]), false, 'Example 4');
is(same_row_column([[1, 2, 3], [3, 1, 2], [3, 2, 1]]), false, 'Example 5');
done_testing();

sub same_row_column
{
     my $mtr = $_[0];
     my $n = scalar @$mtr;
     my $test = join('~', 1 .. $n);
     for my $row_idx ( 0 .. $n - 1 )
     {
          return false if ( 
               join('~', sort { $a .. $b } @{$mtr->[$row_idx]}) ne $test );
     }
     for my $col_idx ( 0 .. $n - 1 )
     {
           return false if (
           join('~',
           sort {$a <=> $b}
           map { $mtr->[$_][$col_idx]}  0 .. $n - 1) ne $test);
     }
     return true;
}
