#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints of length n containing permutation of the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]], ints[ints[ints[i]]], ..., subjected to the following rules:

1. The first element in set[i] starts with the selection of elements ints[i].
2. The next element in set[i] should be ints[ints[i]], and then ints[ints[ints[i]]], and so on.
3. We stop adding right before a duplicate element occurs in set[i].

Return the longest length of a set set[i].
Example 1

Input: @ints = (5, 4, 0, 3, 1, 6, 2)
Output: 4

ints[0] = 5
ints[1] = 4
ints[2] = 0
ints[3] = 3
ints[4] = 1
ints[5] = 6
ints[6] = 2

One of the longest sets set[k]:
set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}

Example 2

Input: @ints = (0, 1, 2)
Output: 1
=cut





use List::Util qw(first);
# use Data::Dump;
use Test2::V0;

is(nested_array(5, 4, 0, 3, 1, 6, 2), 4, 'Example 1');
is(nested_array(0, 1, 2), 1, 'Example 2');
is(nested_array(()), 0, 'Example 3');
is(nested_array(10), 1, 'Example 4');
is(nested_array(1, 5, 10, 2, 50, 3), 5, 'Example 5');
done_testing();

sub nested_array
{
     my @input = @_;
     my @sets;

     for my $i ( 0 .. $#input  )
     {
          my @output;
          $output[0] = $input[$i];
          while (1)
          {
               my $idx = $output[-1];
               my $next_elm = $input[$idx];
               if ( (not defined $next_elm) or 
                    (defined first {$_ == $next_elm} @output)  
                    )
               {
                    push @sets, [@output]; # or just save lengths.
                    last;
               }
               else
               {
                    push @output, $next_elm;
               }
          }
     }
     @sets = sort { scalar @$b <=> scalar @$a } @sets; 
     return defined $sets[0] ? scalar @{$sets[0]} : 0;
}