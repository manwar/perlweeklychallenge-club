#!perl
use strict;
use warnings FATAL => qw(all);

=prompt

You are given an array of integers @A and sliding window size $S.
Write a script to create an array of min from each sliding window.

Example

Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3

Output: (0, 0, 0, 2, 3, 3, 4, 4)
[(1 5 0) 2 9 3 7 6 4 8] = Min (0)
[1 (5 0 2) 9 3 7 6 4 8] = Min (0)
[1 5 (0 2 9) 3 7 6 4 8] = Min (0)
[1 5 0 (2 9 3) 7 6 4 8] = Min (2)
[1 5 0 2 (9 3 7) 6 4 8] = Min (3)
[1 5 0 2 9 (3 7 6) 4 8] = Min (3)
[1 5 0 2 9 3 (7 6 4) 8] = Min (4)
[1 5 0 2 9 3 7 (6 4 8)] = Min (4)
=cut



use List::Util qw(min);
use Test::More;

sub sliding_min
{
     my ($aref, $s) = @_;
     my @min;
     for my $i ( 0 .. $#$aref - $s + 1 )
     {
          push @min, min(@{$aref}[$i .. $i+$s-1]);
     }
     return @min;


}

is_deeply([sliding_min([1, 5, 0, 2, 9, 3, 7, 6, 4, 8], 3)], [0, 0, 0, 2, 3, 3, 4, 4], 'Example 1');

is_deeply([sliding_min([1, 5, 0, 2, 9, 3, 7, 6, 4, 8], 5)], [0, 0, 0, 2, 3, 3], 'Example 2');

done_testing();