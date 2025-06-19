#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers having even elements.
Write a script to to return the decompress list. To decompress, pick adjacent pair (i, j) and replace it with j, i times.

Example 1

Input: @ints = (1, 3, 2, 4)
Output: (3, 4, 4)

Pair 1: (1, 3) => 3 one time  => (3)
Pair 2: (2, 4) => 4 two times => (4, 4)


Example 2

Input: @ints = (1, 1, 2, 2)
Output: (1, 2, 2)

Pair 1: (1, 1) => 1 one time  => (1)
Pair 2: (2, 2) => 2 two times => (2, 2)


Example 3

Input: @ints = (3, 1, 3, 2)
Output: (1, 1, 1, 2, 2, 2)

Pair 1: (3, 1) => 1 three times => (1, 1, 1)
Pair 2: (3, 2) => 2 three times => (2, 2, 2)

=cut





use Test2::V0 -no_srand => 1;

is(decompressed_list(1, 3, 2, 4), [3, 4, 4], 'Example 1');
is(decompressed_list(1, 1, 2, 2), [1, 2, 2], 'Example 1');
is(decompressed_list(3, 1, 3, 2), [1, 1, 1, 2, 2, 2], 'Example 3');
done_testing();

sub decompressed_list
{
     my @arr = @_;
     return 
          [map { ($arr[$_ + 1]) x $arr[$_] } 
          grep { $_ % 2 == 0 }
          0 .. $#arr];
}
