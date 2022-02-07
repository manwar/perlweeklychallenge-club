=head1

Week 151:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-151

Task #1: Binary Tree Depth

    You are given binary tree.

    Write a script to find the minimum depth.

=cut

package Node;

use strict;
use warnings;

sub new {
    my ($class, $value) = @_;

    my $self = {
        left  => undef,
        right => undef,
        value => $value,
    };

    bless $self, $class;

    return $self;
}

package main;

use strict;
use warnings;
use Test::More;

is(min_depth(example_1()), 2, 'Example 1');
is(min_depth(example_2()), 3, 'Example 2');

done_testing;

#
#
# METHODS

sub example_1 {

    #
    #            1
    #           / \
    #          2   3
    #         / \
    #        4   5
    #

    my $root = Node->new(1);
    $root->{left}  = Node->new(2);
    $root->{right} = Node->new(3);
    $root->{left}->{left}  = Node->new(4);
    $root->{left}->{right} = Node->new(5);

    return $root;
}

sub example_2 {

    #
    #            1
    #           / \
    #          2   3
    #         /     \
    #        4       5
    #         \
    #          6
    #

    my $root = Node->new(1);
    $root->{left}  = Node->new(2);
    $root->{right} = Node->new(3);
    $root->{right}->{right} = Node->new(5);
    $root->{left}->{left}   = Node->new(4);
    $root->{left}->{left}->{right} = Node->new(5);

    return $root;
}

sub min_depth {
    my ($node) = @_;

    return 0 unless defined $node;

    my $min_left  = min_depth($node->{left});
    my $min_right = min_depth($node->{right});

    return $min_right + 1 unless defined $node->{left};
    return $min_left  + 1 unless defined $node->{right};

    return ($min_left > $min_right)
           ?
           ($min_right + 1)
            :
           ($min_left  + 1);
}
