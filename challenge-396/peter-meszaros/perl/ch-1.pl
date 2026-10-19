#!/usr/bin/env perl
#
=head1 Task 1: Finishing Order

Submitted by: Mohammad Sajid Anwar

You are given two array of integers, @order and @friends.  The @order (size n)
contains every integer from 1 to n exactly once. The @friends contains ID in
sorted in strictly increasing order.  Write a script to return the array
containing IDs in finishing order.

=head2 Example 1

    Input: @order = (3, 1, 4, 2, 5)
           @friends = (1, 2, 4)
    Output: (1, 4, 2)

    ID 1 finished 2nd.
    ID 4 finished 3rd.
    ID 2 finished 4th.

=head2 Example 2

    Input: @order = (5, 4, 3, 2, 1)
           @friends = (1, 3, 5)
    Output: (5, 3, 1)

    ID 5 finished 1st.
    ID 3 finished 3rd.
    ID 1 finished 5th.

=head2 Example 3

    Input: @order = (2, 4, 1, 3)
           @friends = (1, 2, 3, 4)
    Output: (2, 4, 1, 3)

    ID 2 finished 1st.
    ID 4 finished 2nd.
    ID 1 finished 3rd.
    ID 3 finished 4th.

=head2 Example 4

    Input: @order = (4, 1, 3, 2)
           @friends = (3)
    Output: (3)

=head2 Example 5

    Input: @order = (1, 3, 2, 6, 5, 4)
           @friends = (1, 2, 3)
    Output: (1, 3, 2)

    ID 1 finished 1st.
    ID 3 finished 2nd.
    ID 2 finished 3rd.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {order => [3, 1, 4, 2, 5],    friends => [1, 2, 4],    out => [1, 4, 2],    name => 'Example 1'},
    {order => [5, 4, 3, 2, 1],    friends => [1, 3, 5],    out => [5, 3, 1],    name => 'Example 2'},
    {order => [2, 4, 1, 3],       friends => [1, 2, 3, 4], out => [2, 4, 1, 3], name => 'Example 3'},
    {order => [4, 1, 3, 2],       friends => [3],          out => [3],          name => 'Example 4'},
    {order => [1, 3, 2, 6, 5, 4], friends => [1, 2, 3],    out => [1, 3, 2],    name => 'Example 5'},
);

sub finishing_order
{
    my $order = shift;
    my $friends = shift;

    my %position;
    @position{@$order} = 0 .. $#$order;

    return [sort { $position{$a} <=> $position{$b} } @$friends];
}

for my $case (@cases) {
    my $got = finishing_order($case->{order}, $case->{friends});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
