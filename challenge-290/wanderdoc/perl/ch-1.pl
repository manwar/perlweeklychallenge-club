#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]

Example 1

Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2

Input: @ints = (3, 1, 4, 13)
Output: false

Example 3

Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

=cut





use constant {true => 1, false => 0};
use Test2::V0;

is(double_exist(6, 2, 3, 3), true, 'Example 1');
is(double_exist(3, 1, 4, 13), false, 'Example 2');
is(double_exist(2, 1, 4, 2), true, 'Example 3');
done_testing();


sub double_exist
{
     my @arr = @_;
     @arr = sort { $a <=> $b } @arr;
     for my $i ( 0 .. $#arr - 1 )
     {
          for my $j ( $i + 1 .. $#arr )
          {
               if ( $arr[$j] == 2 * $arr[$i] ) # or $arr[$i] == 2 * $arr[$j]
               {
                    return true;
               }
          }
     }
     return false;
}