#!/usr/bin/env perl
#
=head1 Task 2: Reshape Matrix

Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original
value in the given matrix. If you can't reshape print 0.

=head2 Example 1

    Input: [ 1 2 ]
           [ 3 4 ]

           $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
           $r = 1
           $c = 4

    Output: [ 1 2 3 4 ]

=head2 Example 2

    Input: [ 1 2 3 ]
           [ 4 5 6 ]

           $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
           $r = 3
           $c = 2

    Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

            [ 1 2 ]
            [ 3 4 ]
            [ 5 6 ]

=head2 Example 3

    Input: [ 1 2 ]

           $matrix = [ [ 1, 2 ] ]
           $r = 3
           $c = 2

    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[[1, 2], [3, 4]],        # matrix
      [1, 4]],                 # reshape
     [[1, 2, 3, 4]],           # result
     'Example 1'],
    [[[[1, 2, 3], [4, 5, 6]],  # matrix
      [3, 2]],                 # reshape
     [[1, 2], [3, 4], [5, 6]], # result
     'Example 2'],
    [[[[1, 2]],                # matrix
      [3, 2]],                 # reshape
      0,                       # result
     'Example 3'],
];

sub reshape_matrix
{
    my $m  = $_->[0]->[0];
    my $sh = $_->[0]->[1];

    return 0 if ($m->@* * $m->[0]->@*) != ($sh->[0] * $sh->[1]);

    my @m;
    for my $i (0 .. $m->$#*) {
        push @m, $m->[$i]->@*;
    }
    my @mout;
    for (my $i=0; $i < $sh->[0]; ++$i) {
        my @a = ($sh->[1]*$i) .. ($sh->[1]*($i+1)-1);
        push @mout, [@m[@a]];
    }
    return \@mout;
}

for (@$cases) {
    is(reshape_matrix($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
