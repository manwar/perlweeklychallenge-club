#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary array containing only 0 or/and 1.
Write a script to find out the maximum consecutive 1 in the given array.

Example 1

Input: @binary = (0, 1, 1, 0, 1, 1, 1)
Output: 3


Example 2

Input: @binary = (0, 0, 0, 0)
Output: 0


Example 3

Input: @binary = (1, 0, 1, 0, 1, 1)
Output: 2

=cut

use Test2::V0 -no_srand => 1;
is(consecutive_one(0, 1, 1, 0, 1, 1, 1), 3, 'Example 1');
is(consecutive_one(0, 0, 0, 0), 0, 'Example 2');
is(consecutive_one(1, 0, 1, 0, 1, 1), 2, 'Example 3');
done_testing();

sub consecutive_one
{
     my @arr = @_;
     my @output = (0);
     my $counter = 0;
     for my $elm ( @arr )
     {
          if ( 1 == $elm )
          {
               $counter++;
          }
          else
          {
               push @output, $counter;
               $counter = 0;
          }
     }
     push @output, $counter; # last element.
     return (sort { $b <=> $a } @output)[0];
}
