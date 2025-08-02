#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other domino.

    $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).

Example 1

Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]

Example 2

Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

=cut


use Test2::V0;


is(count_similar_dominos([1, 3], [3, 1], [2, 4], [6, 8]), 2, 'Example 1');
is(count_similar_dominos([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]), 3, 'Example 2');
done_testing();

sub count_similar_dominos
{
     my @arr = @_;
     my %counter;
     for my $stone ( @arr )
     {
          $counter{ join('|', sort {$a <=> $b} @$stone) }++;
     }
     return wantarray ? @counter{ grep $counter{$_} > 1, keys %counter }
          : "@counter{ grep $counter{$_} > 1, keys %counter }";
}


