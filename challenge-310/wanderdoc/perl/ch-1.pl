#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of array of integers.

Write a script to return the common elements in all the arrays.
Example 1

Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
Output: (1, 4)

Example 2

Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
Output: (2)

Example 3

Input: $list = ( [1, 2, 3], [4, 5], [6] )
Output: ()
=cut

use Test2::V0 -no_srand => 1;

is(array_intersection([1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]), [1, 4], 'Example 1');
is(array_intersection([1, 0, 2, 3], [2, 4, 5]), [2], 'Example 2');
is(array_intersection([1, 2, 3], [4, 5], [6]), [], 'Example 3');
done_testing();

sub array_intersection
{
     my @aoa = @_;
     my %common = map {$_ => 1} @{$aoa[0]};
     for my $idx ( 1 .. $#aoa )
     {
          my @intersection = grep { $common{$_} } @{$aoa[$idx]};
          if ( scalar @intersection == 0 )
          {
               return [];
          }
          else
          {
               %common = map {$_ => 1} @intersection;
          }
     }
     return [sort {$a <=> $b} keys %common];
}
