#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] ['l1 ... ln'] ['k1 ... km']

-examples
    run the examples from the challenge
 
-tests
    run some tests

'l1 ... ln'
    elements of the first list as a single argument

'k1 ... lm'
    elements of the second list as a single argument

There may be more or less than two lists.  Call
    $0 '1 2 3 4 5' '6 5 5'
for the second example.

EOS


### Input and Output

{
    my @lists = map {SLL->new(split)} @ARGV;
    say join ' -> ', @{add_linked_lists(@lists)->as_list};
}


### Implementation

# The task is basically a pencil-and-paper addition with carry.
# Retrieve the numbers represented by the digits in the linked lists by
# traversing them, add the numbers and build a new linked list from the
# sum's digits.  This works with any number of input lists.
sub add_linked_lists (@lists) {
    my $sum;
    for my $sll (@lists) {
        $sll->head;
        my $i = 0;
        while (defined (my $data = $sll->data)) {
            $i = $i * 10 + $data;
            $sll->next;
        }
        $sum += $i;
    }
    my $sumlist = SLL->new;
    $sumlist->insert(substr $sum, 0, 1, '')->next while length $sum;

    $sumlist;
}

package SLL;
# A minimal singly linked list implementation just for this task having
# these methods:
# - new: create a SLL from a list of elements
# - head: position the list pointer at the first element
# - insert: insert a new element after the list pointer
# - next: advance the list pointer
# - data: retrieve the data at the list pointer
# - as_list: convert the SLL to an array ref (just to present/check the
#   result)
# List nodes are (unblessed) array refs with the first element pointing
# to the next node and the second element holding the data.  The blessed
# list head is a hash ref holding refs to the first node and the current
# node.  An empty new SLL has some magic as there is no first element
# the list pointer could point to.
#
# This implementation was inspired by Steven Lembark's
# LinkedList::Single (which seems to be gone from the CPAN index).

sub new ($class, @data) {
    my $list = bless {root => []}, $class;
    $list->{cur} = $list->{root};
    $list->insert($_)->next foreach @data;
    $list;
}

sub head ($self) {
    $self->{cur} = $self->{root}[0];
    $self;
}

sub insert ($self, $ins) {
    $self->{cur}[0] = [$self->{cur}[0], $ins];
    $self;
}

sub next ($self) {
    $self->{cur} = $self->{cur}[0];
    $self;
}

sub data ($self) {
    $self->{cur}[1];
}

sub as_list ($self) {
    my @list;
    $self->head;
    while (defined (my $data = $self->data)) {
        push @list, $data;
        $self->next;
    }
    \@list;
}


### Examples and tests

package main;

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is add_linked_lists(SLL->new(1, 2, 3), SLL->new(3, 2, 1))->as_list,
            [4, 4, 4], 'example 1';

        is add_linked_lists(SLL->new(1, 2, 3, 4, 5),
            SLL->new(6, 5, 5))->as_list, [1, 3, 0, 0, 0], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is add_linked_lists(SLL->new(1, 2, 3, 4))->as_list,
            [1, 2, 3, 4], 'single list';
        is add_linked_lists(SLL->new(1, 2),
            SLL->new(2, 3), SLL->new(3, 4))->as_list,
            [6, 9], 'not restricted to two lists';
        is add_linked_lists(SLL->new(1, 2, 3), SLL->new)->as_list,
            [1, 2, 3], 'empty list';
	}

    done_testing;
    exit;
}
