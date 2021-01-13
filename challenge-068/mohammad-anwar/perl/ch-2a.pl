#!/usr/bin/perl

#
# Perl Weekly Challenge - 068
#
# Task #2: Reorder List
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/
#

package Node;

use Moo;

has v => (is => 'rw');
has c => (is => 'rw');

sub show_link {
    my ($self) = @_;

    my $head = $self;
    my @v = ();
    while ($head->c) {
        push @v, $head->v;
        $head = $head->c;
    }
    push @v, $head->v;

    return sprintf("%s", join ' -> ', @v);
}

package main;

use Test::More;

is( reorder_list('1 -> 2 -> 3 -> 4')->show_link,
    '1 -> 4 -> 2 -> 3',
    'testing 1 -> 2 -> 3 -> 4' );
is( reorder_list('1 -> 2 -> 3 -> 4 -> 5')->show_link,
    '1 -> 5 -> 2 -> 4 -> 3',
    'testing 1 -> 2 -> 3 -> 4 -> 5' );
is( reorder_list('1 -> 2 -> 3 -> 4 -> 5 -> 6')->show_link,
    '1 -> 6 -> 2 -> 5 -> 3 -> 4',
    'testing 1 -> 2 -> 3 -> 4 -> 5 -> 6' );

done_testing;

#
#
# METHODS

sub reorder_list {
    my ($list) = @_;

    $list =~ s/\s+//g;
    $list = [ split /\-\>/, $list ];
    my $head = Node->new(v => shift @$list);
    my $link = [ $head ];

    # prepare singly linked list
    foreach my $v (@$list) {
        my $node = Node->new(v => $v);
        $link->[-1]->c($node);
        push @$link, $node;
    }

    # reorder linked list
    my $i = 1;
    foreach (0 .. int($#$list/2)) {
        my $node = pop @$link;
        splice(@$link, $i, 0, $node);

        # remove child from the last node
        $link->[-1]->c(undef);

        # link new node to previous node
        $link->[$i-1]->c($node);

        # make the next node as child of new node
        $node->c($link->[$i+1]);

        $i += 2;
    }

    return $head;
}
