#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.
Write a script to return an array of the ranks of each element: the lowest value has rank 1, next lowest rank 2, etc. If two elements are the same then they share the same rank.

Example 1

Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)


Example 2

Input: @ints = (10, 10, 10)
Output: (1, 1, 1)


Example 3

Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)
=cut

use Test2::V0 -no_srand => 1;

is(rank_array(55, 22, 44, 33), [4, 1, 3, 2], 'Example 1');
is(rank_array(10, 10, 10), [1, 1, 1], 'Example 2');
is(rank_array(5, 1, 1, 4, 3), [4, 1, 1, 3, 2], 'Example 3');
done_testing();

sub rank_array
{
     my @arr = @_;
     my @ranks;
     for my $idx ( 0 .. $#arr )
     {
          push @ranks, {val => $arr[$idx], idx => $idx};
     }
     @ranks = sort {$a->{val} <=> $b->{val}} @ranks;
     my $rank_counter = 1;
     for my $j (0 .. $#ranks) 
     {
          if ( $j == 0 )
          {
               $ranks[$j]->{rank} = $rank_counter;
          }
          elsif ( $ranks[$j]->{val} == $ranks[$j - 1]->{val} )
          {
               $ranks[$j]->{rank} = $rank_counter;
          }
          elsif ( $ranks[$j]->{val} != $ranks[$j - 1]->{val} )
          {
               $rank_counter++;
               $ranks[$j]->{rank} = $rank_counter;
          }
     }
     @ranks = sort {$a->{idx} <=> $b->{idx}} @ranks;
     return [map { $_->{rank} } @ranks];
}
