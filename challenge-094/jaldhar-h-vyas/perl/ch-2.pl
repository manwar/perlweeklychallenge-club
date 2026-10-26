#!/usr/bin/perl
use 5.40.1;

package ListNode;
use Moo;
use namespace::autoclean;

has value => (
    is       => 'rw',
);

has next => (
    is  => 'rw',
    isa => sub { return ref eq __PACKAGE__ },
);

around BUILDARGS => sub ($orig, $class, @args) {
    return { value => $args[0], next => undef };
};

package LinkedList;
use Moo;
use namespace::autoclean;

has _head => (
    is  => 'rw',
    isa => sub { return ref eq 'ListNode' },
);

has _tail => (
    is  => 'rw',
    isa => sub { return ref eq 'ListNode' },
);

has digits => (
    is      => 'ro',
    default => sub { [] },
);

sub BUILD ($self, $args) {
    for my $digit (@{ $args->{digits} }) {
        $self->append($digit);
    }
}

sub append($self, $value) {
    my $node = ListNode->new($value);

    if (defined $self->_head) {
        $self->_tail->next($node);
    }
    else {
        $self->_head($node);
    }
    $self->_tail($node);

    return $self;
}

sub values($self) {
    my @values;
    my $node = $self->_head;

    while (defined $node) {
        push @values, $node->value;
        $node = $node->next;
    }

    return \@values;
}

sub add($self, $other) {
    my @left   = @{ $self->values };
    my @right  = @{ $other->values };
    my @result;
    my $carry = 0;

    while (@left || @right || $carry) {
        my $sum = (pop(@left) // 0) + (pop(@right) // 0) + $carry;
        $carry = int($sum / 10);
        unshift @result, $sum % 10;
    }

    return LinkedList->new(digits => \@result);
}

sub print($self) {
    say join q{ -> }, @{ $self->values };
}

package main;
use warnings;
use feature qw/ class /;
no warnings qw/ experimental::class /;

class TreeNode {
    field $value :param :reader;
    field $left :reader;
    field $right :reader;

    method setLeft($l) {
        $left = $l;
    }

    method setRight($r) {
        $right = $r;
    }
}

sub makeTree(@values) {
    my TreeNode @tree;

    for my $i (keys @values) {
        if ($values[$i] eq q{-}) {
            next;
        }
        $tree[$i] = TreeNode->new(value => $values[$i]);
    }

    for my $i (keys @tree) {
        if (!$tree[$i]) {
            next;
        }

        my $l = 2 * $i + 1;
        my $r = 2 * $i + 2;

        if ($l <= scalar @tree - 1 && $tree[$l]) {
            $tree[$i]->setLeft($tree[$l]);
        }

        if ($r <= scalar @tree - 1 && $tree[$r]) {
            $tree[$i]->setRight($tree[$r]);
        }
    }

    return $tree[0];
}


sub traverse($root, $list) {
    unless (defined $root) {
        return $list;
    }

    $list->append($root->value);

    traverse($root->left, $list);
    traverse($root->right, $list);

    return $list;
}

my ($tree) = @ARGV;
traverse(makeTree(split /\s+/, $tree), LinkedList->new)->print;