#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays of integers, each containing the same elements as the other.
Write a script to return true if one array can be made to equal the other by reversing exactly one contiguous subarray.

Example 1
Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true

Reverse elements: 0-2

Example 2
Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false


Example 3
Input: @source = (2)
       @target = (2)
Output: true
=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(reverse_equals([3, 2, 1, 4], [1, 2, 3, 4]), true, 'Example 1');
is(reverse_equals([1, 3, 4], [4, 1, 3]), false, 'Example 2');
is(reverse_equals([2], [2]), true, 'Example 3');
done_testing();

sub reverse_equals
{
     my ($source, $target) = @_;
     return true if ( join('-', @$source) eq join('-', @$target));
     my @candidates; 
     for my $x ( 0 .. $#$source )
     {
          if ($source->[$x] != $target->[$x])
          {
               my $start = $x; 
               return false if ($x == $#$source and scalar @candidates == 0);
               for my $y ( reverse $x + 1 .. $#$source )
               {
                    if ( $source->[$y] != $target->[$y] )
                    {
                         my $end = $y; 
                         push @candidates, [$start, $end];
                    }
               }
          }
     } 
     for my $cand ( @candidates )
     {
          if ( join('-',@{$source}[$cand->[0] .. $cand->[1]]) eq
               join('-',reverse @{$target}[$cand->[0] .. $cand->[1]])
                    )
          {
               return true;
          }
     }
     return false;
}
