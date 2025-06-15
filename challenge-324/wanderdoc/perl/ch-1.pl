#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers and two integers $r amd $c.
Write a script to create two dimension array having $r rows and $c columns using the given array.

Example 1

Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])


Example 2

Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])


Example 3

Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

=cut

use Test2::V0 -no_srand => 1;

is(my_natatime([1, 2, 3, 4], 2, 2), [[1, 2], [3, 4]], 'Example 1');
is(my_natatime([1, 2, 3], 1, 3), [[1, 2, 3]], 'Example 2');
is(my_natatime([1, 2, 3, 4], 4, 1), [[1], [2], [3], [4]], 'Example 3');
done_testing();

sub my_natatime
{
     my ($aref, $r, $c) = @_;
     die "Rows and columns mismatch!" if ( $r * $c != @$aref );
     my @output;
     while ( my @chunk = splice(@$aref, 0, $c) )
     {
          push @output, [@chunk];
     }
     return \@output;
}
