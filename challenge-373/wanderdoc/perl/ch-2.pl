#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list and a non-negative integer.

Write a script to divide the given list into given non-negative integer equal parts. Return -1 if the integer is more than the size of the list.
Example 1

Input: @list = (1,2,3,4,5), $n = 2
Output: ((1,2,3), (4,5))

5 / 2 = 2 remainder 1.
The extra element goes into the first chunk.

Example 2

Input: @list = (1,2,3,4,5,6), $n = 3
Output: ((1,2), (3,4), (5,6))

6 / 3 = 2 remainder 0.

Example 3

Input: @list = (1,2,3), $n = 2
Output: ((1,2), (3))

Example 4

Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

Example 5

Input: @list = (1,2,3), $n = 4
Output: -1

Example 6

Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))
=cut



use Test2::V0 -no_srand => 1;


is(list_division([(1 .. 5)], 2), [[1,2,3], [4,5]], 'Example 1');
is(list_division([(1 .. 6)], 3), [[1,2], [3,4], [5,6]], 'Example 2');
is(list_division([(1 .. 3)], 2), [[1,2], [3]], 'Example 3');
is(list_division([(1 .. 10)], 5), [[1,2], [3,4], [5,6], [7,8], [9,10]], 'Example 4');
is(list_division([(1 .. 3)], 4), -1, 'Example 5');
is(list_division([(72,57,89,55,36,84,10,95,99,35)], 7), 
     [[72,57], [89,55], [36,84], [10], [95], [99], [35]], 'Example 1');
done_testing();

sub list_division
{
     my ($aref, $n) = @_;
     my $size = scalar @$aref; 
     return -1 if $n > $size;
     my $chunk_size = int($size / $n);
     my $rest = $size % $n;
     my @base_sizes = ($chunk_size) x $n;
     my $i = 0;
     while ( $rest > 0 )
     {
          $base_sizes[$i]++;
          $rest--;
          $i++;
     }
     my @output;
     for my $elm ( @base_sizes )
     {
          push @output, [splice(@$aref, 0, $elm)];
     }
     return [@output];
}
