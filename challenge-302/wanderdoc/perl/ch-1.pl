#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of binary strings, @str, and two integers, $x and $y.
Write a script to return the size of the largest subset of @str such that there are at most $x 0's and $y 1's in the subset.
A set m is a subset of n if all elements of m are also elements of n.
Example 1
Input: @str = ("10", "0001", "111001", "1", "0")
         $x = 5
         $y = 3
Output: 4
The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")
Example 2
Input: @str = ("10", "1", "0")
         $x = 1
         $y = 1
Output: 2
The largest subset with at most one 0's and one 1's:
("1", "0")
=cut

# use Data::Dump;
use List::Util qw(max);
use Test2::V0 -no_srand => 1;

is(zeroes_and_ones(["10", "0001", "111001", "1", "0"], 5, 3), 4, 'Example 1');;
is(zeroes_and_ones(["10", "1", "0"], 1, 1), 2, 'Example 2');;
done_testing();

sub zeroes_and_ones
{
     my ($aref, $x, $y) = @_;
     my $dp; # maximum subset size.
     return 0 if (@$aref == 0 or $x == 0 or $y == 0);
     for my $zero ( 0 .. $x )
     {
          for my $one ( 0 .. $y )
          {
               $dp->[$zero][$one] = 0;
          }
     }
     
     for my $chunk ( @$aref )
     {
          my $this_zeroes = $chunk =~ tr/0/0/;
          my $this_ones   = $chunk =~ tr/1/1/;
          
          for my $i ( reverse $this_zeroes .. $x )
          {
               for my $j ( reverse $this_ones .. $y )
               {
                    $dp->[$i][$j] = 
                         max($dp->[$i][$j], $dp->[$i - $this_zeroes][$j - $this_ones] + 1);
               }
          }
     }
     # dd $dp;
     return $dp->[$x][$y];
}