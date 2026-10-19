#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Finishing Order (WWC 396 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given two arrays of integers, @order and @friends.
The @order (size n) contains every integer from 1 to n exactly once, representing the race finish order.
The @friends contains IDs sorted in strictly increasing order.
Write a script to return the array containing friend IDs in finishing order.

=cut

my $ARGS_CHECK = compile( ArrayRef [Int], ArrayRef [Int] );

sub finishing_order ( $order, $friends ) {
    ( $order, $friends ) = $ARGS_CHECK->( $order, $friends );

    my %is_friend = map { $_ => 1 } @$friends;
    my @result;

    for my $id (@$order) {
        if ( exists $is_friend{$id} ) {
            push @result, $id;
        }
    }

    return \@result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            order    => [ 3, 1, 4, 2, 5 ],
            friends  => [ 1, 2, 4 ],
            expected => [ 1, 4, 2 ],
        },
        {
            label    => 'Example 2',
            order    => [ 5, 4, 3, 2, 1 ],
            friends  => [ 1, 3, 5 ],
            expected => [ 5, 3, 1 ],
        },
        {
            label    => 'Example 3',
            order    => [ 2, 4, 1, 3 ],
            friends  => [ 1, 2, 3, 4 ],
            expected => [ 2, 4, 1, 3 ],
        },
        {
            label    => 'Example 4',
            order    => [ 4, 1, 3, 2 ],
            friends  => [3],
            expected => [3],
        },
        {
            label    => 'Example 5',
            order    => [ 1, 3, 2, 6, 5, 4 ],
            friends  => [ 1, 2, 3 ],
            expected => [ 1, 3, 2 ],
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = finishing_order( $case->{order}, $case->{friends} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 finishing_order(\@order, \@friends)

Filters the race finishing order to return friend IDs in the order they finished.

=cut
