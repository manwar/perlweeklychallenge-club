#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers having four or more elements.

Write a script to find two pairs of numbers from this list (four numbers total) so that the difference between their products is as large as possible.

In the end return the max difference.

    With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).


Example 1

Input: @ints = (5, 9, 3, 4, 6)
Output: 42

Pair 1: (9, 6)
Pair 2: (3, 4)
Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42


Example 2

Input: @ints = (1, -2, 3, -4)
Output: 10

Pair 1: (1, -2)
Pair 2: (3, -4)


Example 3

Input: @ints = (-3, -1, -2, -4)
Output: 10

Pair 1: (-1, -2)
Pair 2: (-3, -4)


Example 4

Input: @ints = (10, 2, 0, 5, 1)
Output: 50

Pair 1: (10, 5)
Pair 2: (0, 1)


Example 5

Input: @ints = (7, 8, 9, 10, 10)
Output: 44

Pair 1: (10, 10)
Pair 2: (7, 8)

=cut

use List::Util qw(all); #  max product);

use Test2::V0 -no_srand => 1;



is(max_diff(5, 9, 3, 4, 6), 42, 'Example 1');
is(max_diff(1, -2, 3, -4), 10, 'Example 2');
is(max_diff(-3, -1, -2, -4), 10, 'Example 3');
is(max_diff(10, 2, 0, 5, 1), 50, 'Example 4');
is(max_diff(7, 8, 9, 10, 10), 44, 'Example 5');
is(max_diff(-5, 1, 2, 3, 5), 31, 'Example 6a');
is(max_diff(-5, -1, 2, 3, 5), 31, 'Example 7a');
done_testing();


sub max_diff
{
     my @arr = @_;
     if ( (all {$_ >= 0} @arr) or (all { $_ < 0 } @arr) )
     {
          @arr = sort {$a <=> $b} @arr;
          if ( all {$_ >= 0} @arr )
          {
               return product(@arr[$#arr-1, $#arr]) - 
                      product(@arr[0, 1]);
          }
          else # i.e. < 0
          {
               return product(@arr[0, 1]) - 
                      product(@arr[$#arr-1, $#arr]);
          }
     }
     else
     {
          my $max = (~0+1)*-1;
          for my $i ( @arr )
          {
               for my $j ( @arr )
               {
                    next if $i == $j;
                    for my $k ( @arr )
                    {
                         next if ($k == $j or $k == $i);
                         for my $m ( @arr )
                         {
                              next if ($m == $k or $m == $j or $m == $i);
                              my $first = product($i, $j);
                              my $second = product($k, $m);
                              $max = ($first - $second) > $max ? 
                                     ($first - $second) : $max;
                         }
                    }
               }
          }
          return $max;
     }
     

}

sub product
{
     return $_[0] * $_[1];
}
