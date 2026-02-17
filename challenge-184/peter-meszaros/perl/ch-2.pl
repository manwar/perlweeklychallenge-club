#!/usr/bin/env perl
#
=head1 Task 2: Split Array

Submitted by: Mohammad S Anwar

You are given list of strings containing 0-9 and a-z separated by space only.
Write a script to split the data into two arrays, one for integers and one for
alphabets only.

=head2 Example 1

    Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
    Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]

=head2 Example 2

    Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
    Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [['a 1 2 b 0', '3 c 4 d'],
        [[[1, 2, 0], [3, 4]], [['a', 'b'], ['c', 'd']]], "Example 1"],
    [['1 2', 'p q r', 's 3', '4 5 t'],
        [[[1, 2], [3], [4, 5]], [['p', 'q', 'r'], ['s'], ['t']]], "Example 2"],
];

sub split_array
{
    my $list = shift;

    my (@integers, @alphabets);
    for my $l (@$list) {
        my @chars = split / /, $l;
        my @ints  = grep { /^[0-9]$/ } @chars;
        my @alphs = grep { /^[a-z]$/ } @chars;
        push @integers,  \@ints  if @ints;
        push @alphabets, \@alphs if @alphs;
    }
    return [\@integers, \@alphabets];
}

for (@$cases) {
    is(split_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
