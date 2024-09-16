#!/usr/bin/env perl
#
=head1 Task 2: Number Placement

Submitted by: Mohammad S Anwar

You are given a list of numbers having just 0 and 1. You are also given
placement count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given
list. The only condition is that you can only replace when there is no 1 on
either side. Print 1 if it is possible otherwise 0.

=head2 Example 1:

	Input: @numbers = (1,0,0,0,1), $count = 1
	Output: 1

	You are asked to replace only one 0 as given count is 1.
	We can easily replace middle 0 in the list i.e. (1,0,1,0,1).

=head2 Example 2:

	Input: @numbers = (1,0,0,0,1), $count = 2
	Output: 0

	You are asked to replace two 0's as given count is 2.
	It is impossible to replace two 0's.

=head2 Example 3:

	Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
	Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[1, 0, 0, 0, 1],             1], 1, 'Example 1'],
	[[[1, 0, 0, 0, 1],             2], 0, 'Example 2'],
	[[[1, 0, 0, 0, 0, 0, 0, 0, 1], 3], 1, 'Example 3'],
];

sub number_placement
{
    my $lst = $_[0]->[0];
    my $cnt = $_[0]->[1];

    my $rep = 0;
    for my $i (1 .. ($#$lst-1)) {
        if ($lst->[$i-1] == 0 &&
            $lst->[$i]   == 0 &&
            $lst->[$i+1] == 0) {
            $lst->[$i] = 1;
            ++$rep;
        }
    }
    return ($rep >= $cnt) ? 1 : 0;
}

for (@$cases) {
    is(number_placement($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
