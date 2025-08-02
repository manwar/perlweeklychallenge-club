#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear before 0.
A row i is weaker than a row j if one of the following is true:
a) The number of 1s in row i is less than the number of 1s in row j.
b) Both rows have the same number of 1 and i < j.
Write a script to return the order of rows from weakest to strongest.

Example 1

Input: $matrix = [
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 0],
                   [1, 0, 0, 0, 0],
                   [1, 1, 0, 0, 0],
                   [1, 1, 1, 1, 1]
                 ]
Output: (2, 0, 3, 1, 4)

The number of 1s in each row is:
- Row 0: 2
- Row 1: 4
- Row 2: 1
- Row 3: 2
- Row 4: 5

Example 2

Input: $matrix = [
                   [1, 0, 0, 0],
                   [1, 1, 1, 1],
                   [1, 0, 0, 0],
                   [1, 0, 0, 0]
                 ]
Output: (0, 2, 3, 1)

The number of 1s in each row is:
- Row 0: 1
- Row 1: 4
- Row 2: 1
- Row 3: 1

=cut

use List::Util qw(sum);
use Test2::V0;

my $mtr =
[
 [1, 1, 0, 0, 0],
 [1, 1, 1, 1, 0],
 [1, 0, 0, 0, 0],
 [1, 1, 0, 0, 0],
 [1, 1, 1, 1, 1]
];

sub sort_matrix
{
     my $m = $_[0];
     my @output =
          map { $_->[2] }
          sort { $a->[1] <=> $b->[1] or $a->[2] <=> $b->[2] }
          map { [ $m->[$_], sum(@{$m->[$_]}),  $_ ] }
          0 .. $#$m;
     return @output;
}


is([sort_matrix($mtr)], [2, 0, 3, 1, 4], 'Example 1');

$mtr =
[
 [1, 0, 0, 0],
 [1, 1, 1, 1],
 [1, 0, 0, 0],
 [1, 0, 0, 0]
];
is([sort_matrix($mtr)], [0, 2, 3, 1], 'Example 2');

done_testing();