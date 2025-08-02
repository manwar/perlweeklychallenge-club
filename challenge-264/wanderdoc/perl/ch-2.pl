#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays of integers, @source and @indices. The @indices can only contains integers 0 <= i < size of @source. Write a script to create target array by insert at index $indices[i] the value $source[i].
Example 1 Input: @source  = (0, 1, 2, 3, 4) @indices = (0, 1, 2, 2, 1)
Output: (0, 4, 1, 3, 2)
@source  @indices  @target
0        0         (0)
1        1         (0, 1)
2        2         (0, 1, 2)
3        2         (0, 1, 3, 2)
4        1         (0, 4, 1, 3, 2)

Example 2 Input: @source  = (1, 2, 3, 4, 0) @indices = (0, 1, 2, 3, 0)
Output: (0, 1, 2, 3, 4)
@source  @indices  @target
1        0         (1)
2        1         (1, 2)
3        2         (1, 2, 3)
4        3         (1, 2, 3, 4)
0        0         (0, 1, 2, 3, 4)

Example 3 Input: @source  = (1) @indices = (0)
Output: (1)
=cut

use Test2::V0;

is(target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2], 'Example 1');
is(target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4], 'Example 2');
is(target_array([1], [0]), [1], 'Example 3');
done_testing();


sub target_array
{
     my ($aref_source, $aref_indices) = @_;
     my @output;
     for my $i ( 0 .. $#$aref_source )
     {
          if ( defined $output[$aref_indices->[$i]] )
          {
               my $this = $output[$aref_indices->[$i]];
               splice(@output, $aref_indices->[$i], 1, $aref_source->[$i], $this);
          }
          else
          {
               $output[$aref_indices->[$i]] = $aref_source->[$i];
          }
     }
     return \@output;
}
