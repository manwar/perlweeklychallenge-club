#!/usr/bin/perl

#
# Perl Weekly Challenge - 071
#
# Task #2: Trim Linked List
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/
#

package Node;

use Moo;

has v => (is => 'rw');
has p => (is => 'rw');

sub trim {
    my ($self, $position) = @_;

    die "ERROR: Invalid position [$position].\n"
        unless ($position =~ /^\d+$/);

    my $tail  = $self;
    my $count = 1;
    my $node;

    while ($tail->p) {
        if ($position > $count) {
            $node = $tail;
        }
        elsif ($position == $count) {
            if (defined $node) {
                # Remove current node by making the
                # parent of  current node as parent
                # of previous node
                $node->p($tail->p);
            }
            else {
                # If you're taking first from the end
                # then return the parent of last node
                return $tail->p;
            }
        }

        $tail = $tail->p;
        $count++;
    }

    # Take the first node off if and only if:
    # a) you reached the first node or
    # b) given position is more than the total nodes
    $node->p(undef) if ($count <= $position);

    return $self;
}

sub show {
    my ($self) = @_;

    my $node = $self;
    my @v = ();
    while ($node->p) {
        push @v, $node->v;
        $node = $node->p;
    }
    push @v, $node->v;

    return join ' -> ', reverse @v;
}

package main;

my $L = $ARGV[0] || '1 -> 2 -> 3 -> 4 -> 5';
my $N = $ARGV[1] || 2;
print create_linked_list($L)->trim($N)->show, "\n";

#
#
# METHOD

sub create_linked_list {
    my ($list) = @_;

    $list =~ s/\s+//g;
    die "ERROR: Invalid list [$list].\n"
        if ($list !~ /\-\>/);

    $list = [ split /\-\>/, $list ];
    my $node = Node->new(v => pop @$list);
    my $tail = $node;

    while (@$list) {
        my $_node = Node->new(v => pop @$list);
        $tail->p($_node);
        $tail = $_node;
    }

    print $node->show, "\n";

    return $node;
}
