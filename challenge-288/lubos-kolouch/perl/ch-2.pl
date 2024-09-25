#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script finds the size of the largest contiguous block in a given rectangular matrix of 'x' and 'o'.

A contiguous block consists of elements containing the same symbol which share an edge (not just a corner) with other elements in the block, and where there is a path between any two of these elements that crosses only those shared edges.

=head1 FUNCTIONS

=head2 largest_contiguous_block(\@matrix)

Given a reference to a 2D array representing the matrix, returns the size of the largest contiguous block.

=over 4

=item * C<\@matrix> - Reference to a 2D array of 'x' and 'o'.

=back

Returns the size of the largest contiguous block as an integer.

=back

=cut

sub largest_contiguous_block {
    my ($matrix_ref) = @_;
    my @matrix = @$matrix_ref;
    my $rows = scalar @matrix;
    my $cols = scalar @{ $matrix[0] };
    my @visited = map { [(0) x $cols] } (0 .. $rows - 1);
    my $max_block_size = 0;

    for my $i (0 .. $rows - 1) {
        for my $j (0 .. $cols - 1) {
            if (!$visited[$i][$j]) {
                my $block_size = dfs($matrix_ref, \@visited, $i, $j, $matrix[$i][$j]);
                $max_block_size = $block_size if $block_size > $max_block_size;
            }
        }
    }

    return $max_block_size;
}

sub dfs {
    my ($matrix_ref, $visited_ref, $i, $j, $symbol) = @_;
    my @matrix = @$matrix_ref;
    my $rows = scalar @matrix;
    my $cols = scalar @{ $matrix[0] };

    return 0 if $i < 0 || $i >= $rows || $j < 0 || $j >= $cols;
    return 0 if $visited_ref->[$i][$j];
    return 0 if $matrix[$i][$j] ne $symbol;

    $visited_ref->[$i][$j] = 1;
    my $size = 1;

    # Explore neighbors (up, down, left, right)
    $size += dfs($matrix_ref, $visited_ref, $i - 1, $j, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i + 1, $j, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i, $j - 1, $symbol);
    $size += dfs($matrix_ref, $visited_ref, $i, $j + 1, $symbol);

    return $size;
}

# Unit Tests
my $matrix1 = [
    ['x', 'x', 'x', 'x', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'x', 'x', 'o', 'o'],
];
is(largest_contiguous_block($matrix1), 11, 'Example 1');

my $matrix2 = [
    ['x', 'x', 'x', 'x', 'x'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'x', 'x', 'x', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
];
is(largest_contiguous_block($matrix2), 11, 'Example 2');

my $matrix3 = [
    ['x', 'x', 'x', 'o', 'o'],
    ['o', 'o', 'o', 'x', 'x'],
    ['o', 'x', 'x', 'o', 'o'],
    ['o', 'o', 'o', 'x', 'x'],
];
is(largest_contiguous_block($matrix3), 7, 'Example 3');

done_testing();
