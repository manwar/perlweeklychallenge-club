#!/usr/bin/env perl

# Challenge 068
#
# TASK #2 › Reorder List
# Submitted by: Mohammad S Anwar
# You are given a singly linked list $L as below:
#
# L0 ?  L1 ?  … ?  Ln-1 ?  Ln
# Write a script to reorder list as below:
#
# L0 ?  Ln ?  L1 ?  Ln-1 ?  L2 ?  Ln-2 ?
# You are ONLY allowed to do this in-place without altering the nodes’ values.
#
# Example
# Input:  1 ?  2 ?  3 ?  4
# Output: 1 ?  4 ?  2 ?  3

use Modern::Perl;
use Test::More;

is_deeply reorder_list([1,[2,[3,[4]]]]), [1,[4,[2,[3]]]];
done_testing;

sub reorder_list {
    my($l) = @_;
    # get second element
    my $tail = $l->[1];
    # get and remove last element
    my $p = $tail;
    my $last;
    while ($p->[1]) {
        $last = $p;
        $p = $p->[1];
    }
    my $eln = pop(@{$last});

    return [$l->[0], [$eln->[0], $tail]];
}
