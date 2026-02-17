#!/usr/bin/env perl
#
=head1 Task 1: Unique Array

Submitted by: Mohammad S Anwar

You are given list of arrayrefs.  Write a script to remove the duplicate
arrayrefs from the given list.

=head2 Example 1

    Input: @list = ([1,2], [3,4], [5,6], [1,2])
    Output: ([1,2], [3,4], [5,6])

=head2 Example 2

    Input: @list = ([9,1], [3,7], [2,5], [2,5])
    Output: ([9, 1], [3,7], [2,5])

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[1, 2], [3, 4], [5, 6], [1, 2]], [[1, 2], [3, 4], [5, 6]], 'Example 1'],
    [[[9, 1], [3, 7], [2, 5], [2, 5]], [[9, 1], [3, 7], [2, 5]], 'Example 2'],
];

sub unique_array
{
    my $list = shift;
    my %seen;
    my @result;

    for my $aref (@$list) {
        my $key = join(',', @$aref);
        push @result, $aref unless $seen{$key}++;
    }

    return \@result;
}

for (@$cases) {
    is(unique_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
