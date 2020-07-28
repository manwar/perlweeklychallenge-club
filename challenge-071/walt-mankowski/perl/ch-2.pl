#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use lib '.';
use Node;

# TASK #2 › Trim Linked List
# Submitted by: Mohammad S Anwar
#
# You are given a singly linked list and a positive integer $N (>0).
#
# Write a script to remove the $Nth node from the end of the linked
# list and print the linked list.
#
# If $N is greater than the size of the linked list then remove the
# first node of the list.
#
# NOTE: Please use pure linked list implementation.
# Example
# Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
# when $N = 1
# Output: 1 -> 2 -> 3 -> 4
# when $N = 2
# Output: 1 -> 2 -> 3 -> 5
# when $N = 3
# Output: 1 -> 2 -> 4 -> 5
# when $N = 4
# Output: 1 -> 3 -> 4 -> 5
# when $N = 5
# Output: 2 -> 3 -> 4 -> 5
# when $N = 6
# Output: 2 -> 3 -> 4 -> 5

my $N = shift @ARGV;
my $head = Node->new(undef);

make_list($head, 1..5);
print_list($head);
remove_from_end($head, $N);
print_list($head);

sub make_list($head, @a) {
    my $node = $head;
    for my $i (@a) {
        $node->set_next(Node->new($i));
        $node = $node->next;
    }
}

sub print_list($head) {
    my $node = $head->next;
    while (defined $node) {
        print $node->val;
        print " -> " if defined $node->next;
        $node = $node->next;
    }
    say "";
}

sub list_length($head) {
    my $node = $head;
    my $len = 0;
    while (defined $node->next) {
        $len++;
        $node = $node->next;
    }
    return $len;
}

sub remove_from_end($head, $n) {
    # get to the position before the node to delete
    my $pos = list_length($head);
    my $node = $head;
    while ($pos > $n) {
        $node = $node->next;
        $pos--;
    }

    # remove it
    $node->set_next($node->next->next);
}
