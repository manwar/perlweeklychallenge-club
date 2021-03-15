#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given triangle array. Write a script to find the minimum path sum from top to bottom.
When you are on index i on the current row then you may move to either index i or index i + 1 on the next row.
Example 1: Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ] Output: 8
Explanation: The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8.
Example 2: Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ] Output: 7
Explanation: The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7.
=cut






use List::Util qw(min);
use Test::More;

sub triangle_path
{
     my $aref = $_[0];
     my $mtr;

     do { my $i = $_;
          do { $mtr->[$i][$_] = 0 } for 0 .. $#$aref }
          for 0 .. $#$aref;
     $mtr->[$#$aref] = $aref->[$#$aref];
     
     for my $i ( reverse 0 .. $#$aref - 1 )
     {
          my $row = $aref->[$i];

          for my $j (0 .. $#$row)
          {
               my $left = $mtr->[$i + 1][$j];


               my $right = $mtr->[$i + 1][$j + 1];
               $mtr->[$i][$j] = $row->[$j] + min($left, $right);
          }

     }
     return $mtr->[0][0];
}


is(triangle_path([[1], [2,4], [6,4,9], [5,1,7,2]]), 8, 'Example 1');;
is(triangle_path([[3], [3,1], [5,2,3], [4,3,1,3]]), 7, 'Example 2');;
done_testing();