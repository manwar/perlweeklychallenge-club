#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays of integers.
Write a script to return the minimum integer common to both arrays. If none found return -1.
Example 1

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3

The common integer in both arrays: 3, 4
The minimum is 3.


Example 2

Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2


Example 3

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1
=cut

use Test2::V0 -no_srand => 1;

is(minimum_common([1, 2, 3, 4], [3, 4, 5, 6]), 3, 'Example 1');
is(minimum_common([1, 2, 3], [2, 4]), 2, 'Example 2');
is(minimum_common([1, 2, 3, 4], [5, 6, 7, 8]), -1, 'Example 3');
done_testing();



sub minimum_common
{
     my ($aref_1, $aref_2) = @_;
     my %first = map { $_ => 1 } @$aref_1;
     my $min;
     for my $elm ( @$aref_2 )
     {
          if ( defined $first{$elm} )
          {
               $min = $elm if ( !defined $min or $elm < $min );
          }
     }
     return defined $min? $min : -1;
}
