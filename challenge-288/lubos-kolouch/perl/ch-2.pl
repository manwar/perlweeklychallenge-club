#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use List::Util qw(max);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Contiguous Block (The Weekly Challenge 288 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script finds the size of the largest contiguous block in a given rectangular matrix of 'x' and 'o'.

A contiguous block consists of elements containing the same symbol which share an edge (not just a corner) with other elements in the block, and where there is a path between any two of these elements that crosses only those shared edges.

=head1 FUNCTIONS

=head2 largest_contiguous_block($matrix_ref)

Given a reference to a 2D array representing the matrix, returns the size of the largest contiguous block as an integer.

=cut

signature_for largest_contiguous_block => (
    method     => 0,
    positional => [ ArrayRef[ArrayRef[Str]] ],
);

sub dfs ($matrix_ref, $visited_ref, $i, $j, $symbol) {
    my $rows = scalar @$matrix_ref;
    my $cols = scalar @{ $matrix_ref->[0] };

    return 0 if $i < 0 || $i >= $rows || $j < 0 || $j >= $cols;
    return 0 if $visited_ref->[$i][$j];
    return 0 if $matrix_ref->[$i][$j] ne $symbol;

    $visited_ref->[$i][$j] = 1;
    my $size = 1;

    # Explore neighbors (up, down, left, right)
    $size += dfs($matrix_ref, $visited_ref, $i - 1, $j, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i + 1, $j, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i, $j - 1, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i, $j + 1, $symbol);

    return $size;
}

sub largest_contiguous_block ($matrix_ref) {
    return 0 if !@$matrix_ref || !@{ $matrix_ref->[0] };

    my $rows = scalar @$matrix_ref;
    my $cols = scalar @{ $matrix_ref->[0] };
    my @visited = map { [(0) x $cols] } (0 .. $rows - 1);
    my $max_block_size = 0;

    for my $i (0 .. $rows - 1) {
        for my $j (0 .. $cols - 1) {
            if (!$visited[$i][$j]) {
                my $block_size = dfs($matrix_ref, \@visited, $i, $j, $matrix_ref->[$i][$j]);
                $max_block_size = $block_size if $block_size > $max_block_size;
            }
        }
    }

    return $max_block_size;
}

sub _run_cli (@args) {
    _run_tests();
}

sub _run_tests {
    my $matrix1 = [
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'o', 'o'],
    ];

    my $matrix2 = [
        ['x', 'x', 'x', 'x', 'x'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
    ];

    my $matrix3 = [
        ['x', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
        ['o', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
    ];

    my @cases = (
        { label => 'Example 1', matrix => $matrix1, expected => 11 },
        { label => 'Example 2', matrix => $matrix2, expected => 11 },
        { label => 'Example 3', matrix => $matrix3, expected => 7 },
        { label => 'Single cell', matrix => [['x']], expected => 1 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( largest_contiguous_block( $case->{matrix} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
