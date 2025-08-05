#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.
Write a script to duplicate each occurrence of zero, shifting the remaining elements to the right. The elements beyond the length of the original array are not written.

Example 1

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Output: (1, 0, 0, 2, 3, 0, 0, 4)

Each zero is duplicated.
Elements beyond the original length (like 5 and last 0) are discarded.


Example 2

Input: @ints = (1, 2, 3)
Output: (1, 2, 3)

No zeros exist, so the array remains unchanged.


Example 3

Input: @ints = (1, 2, 3, 0)
Output: (1, 2, 3, 0)


Example 4

Input: @ints = (0, 0, 1, 2)
Output: (0, 0, 0, 0)


Example 5

Input: @ints = (1, 2, 0, 3, 4)
Output: (1, 2, 0, 0, 3)
=cut

use Test2::V0 -no_srand => 1;
is([duplicate_zeroes(1, 0, 2, 3, 0, 4, 5, 0)], [1, 0, 0, 2, 3, 0, 0, 4], 'Example 1');
is([duplicate_zeroes(1, 2, 3)], [1, 2, 3], 'Example 2');
is([duplicate_zeroes(1, 2, 3, 0)], [1, 2, 3, 0], 'Example 3');
is([duplicate_zeroes(0, 0, 1, 2)], [0, 0, 0, 0], 'Example 4');
is([duplicate_zeroes(1, 2, 0, 3, 4)], [1, 2, 0, 0, 3], 'Example 1');
done_testing();


# use Data::Dump;

sub duplicate_zeroes
{
     my @arr = @_;
     my $cursor = 0;
     my $last_elm = $#arr;
     
     while ( $cursor <= $last_elm )
     {
          if ($arr[$cursor] != 0)
          {
               $cursor++;
          }
     
          else
          {
               splice(@arr, $cursor, 0, 0);
               $cursor += 2;
          }
     }
     return @arr[0 .. $last_elm];
}
