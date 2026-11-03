#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Magic Number (The Weekly Challenge 268 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each elements of one
of the array gives the second array. Elements order is not important.

=head1 FUNCTIONS

=head2 find_magic_number($x, $y)

Given references to two arrays of integers of the same size, returns the magic number
that transforms array x into array y.

=cut

signature_for find_magic_number => (
    method     => 0,
    positional => [ ArrayRef [Int], ArrayRef [Int] ],
);

sub find_magic_number ( $x, $y ) {
    die "Arrays must not be empty\n" if !@$x || !@$y;
    die "Arrays must be of the same size\n" if @$x != @$y;

    my @sorted_x = sort { $a <=> $b } @$x;
    my @sorted_y = sort { $a <=> $b } @$y;

    my $diff = $sorted_y[0] - $sorted_x[0];
    for my $i ( 0 .. $#sorted_x ) {
        if ( $sorted_y[$i] - $sorted_x[$i] != $diff ) {
            die "No magic number found\n";
        }
    }

    return $diff;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    _run_tests();
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            x        => [ 3, 7, 5 ],
            y        => [ 9, 5, 7 ],
            expected => 2,
        },
        {
            label    => 'Example 2',
            x        => [ 1, 2, 1 ],
            y        => [ 5, 4, 4 ],
            expected => 3,
        },
        {
            label    => 'Example 3',
            x        => [ 2 ],
            y        => [ 5 ],
            expected => 3,
        },
        {
            label    => 'Negative numbers',
            x        => [ -5, -2 ],
            y        => [ -1, 2 ],
            expected => 4,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( find_magic_number( $case->{x}, $case->{y} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
