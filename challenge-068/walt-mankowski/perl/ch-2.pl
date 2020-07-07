#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use lib '.';
use Node;

# TASK #2 › Reorder List
# Submitted by: Mohammad S Anwar
#
# You are given a singly linked list $L as below:
#
# L0 →  L1 →  … →  Ln-1 →  Ln
#
# Write a script to reorder list as below:
#
# L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 →
#
# You are ONLY allowed to do this in-place without altering the nodes’ values.
# Example
#
# Input:  1 →  2 →  3 →  4
# Output: 1 →  4 →  2 →  3

my $list = make_list(1..10);
print_list($list);
reorder_list($list);
print_list($list);

sub make_list(@a) {
    my $list = Node->new(shift @a);
    my $cur = $list;
    for my $val (@a) {
        my $node = Node->new($val);
        $cur->set_next($node);
        $cur = $node;
    }
    return $list;
}

sub print_list($list) {
    while (defined($list)) {
        print $list->val;
        if (defined($list->next)) {
            print " => ";
        }
        $list = $list->next;
    }
    print "\n";
}

sub reorder_list($list) {
    # save the nodes in an array
    my @a;
    while (defined $list) {
        push @a, $list;
        $list = $list->next;
    }

    # now reorder things
    my $n = $#a;
    for my $i (0..$n / 2 - 1) {
        $a[$n-$i]->set_next($a[$i]->next);
        $a[$i]->set_next($a[$n-$i]);
        $a[$n-$i-1]->set_next(undef);
    }
}
