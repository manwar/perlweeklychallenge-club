#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of more than one rows then return smallest row number.
Example 1

Input: $matrix = [ [0, 1],
                   [1, 0],
                 ]
Output: 1

Row 1 and Row 2 have the same number of ones, so return row 1.

Example 2

Input: $matrix = [ [0, 0, 0],
                   [1, 0, 1],
                 ]
Output: 2

Row 2 has the maximum ones, so return row 2.

Example 3

Input: $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ]
Output: 2

Row 2 have the maximum ones, so return row 2.
=cut




use List::Util qw(sum);
# use POSIX qw(Inf);
use Scalar::Util qw(dualvar);
use Test2::V0;

is(max_ones([[0, 1], [1, 0]]), 1, 'Example 1');
is(max_ones([[0, 0, 0], [1, 0, 1]]), 2, 'Example 2');
is(max_ones([[0, 0], [1, 1], [0, 0]]), 2, 'Example 3');

done_testing();

sub max_ones
{
     my $mtr = $_[0];
     my $max = dualvar(0, "placeholder");
     for my $row ( 1 .. $#$mtr + 1 ) # ( 0 .. $#$mtr )
     {
          my $sum = sum(@{$mtr->[$row - 1]});
          if ( $sum > $max )
          {
               $max = dualvar($sum, "$row");
          }
     }
     return $max eq 'placeholder' ? undef : $max . ''; 
}