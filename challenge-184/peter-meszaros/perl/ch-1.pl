#!/usr/bin/env perl
#
=head1 Task 1: Sequence Number

Submitted by: Mohammad S Anwar

You are given list of strings in the format aa9999 i.e. first 2 characters can
be anything 'a-z' followed by 4 digits '0-9'.  Write a script to replace the
first two characters with sequence starting with '00', '01', '02' etc.

=head2 Example 1

    Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
    Output: ('001234', '015678', '021342')

=head2 Example 2

    Input: @list = ( 'pq1122', 'rs3334')
    Output: ('001122', '013334')

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [['ab1234', 'cd5678', 'ef1342'], ['001234', '015678', '021342'], 'Example 1'],
    [          ['pq1122', 'rs3334'],           ['001122', '013334'], 'Example 2'],
];

sub sequence_number
{
    my $list = shift;
    my $counter = 0;

    s/^[a-z]{2}/sprintf("%02d", $counter++)/e for @$list;

    return $list;
}

for (@$cases) {
    is(sequence_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
