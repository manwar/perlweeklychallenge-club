#!/usr/bin/perl

use v5.40;

use Test::More tests => 3;

sub mark_cell {
    my ($matrix, $row, $column, $block) = @_;
    $matrix->[$row][$column][1] = $block;
    if ($row > 0
            and $matrix->[$row - 1][$column][0] eq $matrix->[$row][$column][0]
            and $matrix->[$row - 1][$column][1] == 0) {
        mark_cell($matrix, $row - 1, $column, $block);
    }
    if ($column > 0
            and $matrix->[$row][$column - 1][0] eq $matrix->[$row][$column][0]
            and $matrix->[$row][$column - 1][1] == 0) {
        mark_cell($matrix, $row, $column - 1, $block);
    }
    if ($row < $#$matrix
            and $matrix->[$row + 1][$column][0] eq $matrix->[$row][$column][0]
            and $matrix->[$row + 1][$column][1] == 0) {
        mark_cell($matrix, $row + 1, $column, $block);
    }
    if ($column < $#{ $matrix->[0] }
            and $matrix->[$row][$column + 1][0] eq $matrix->[$row][$column][0]
            and $matrix->[$row][$column + 1][1] == 0) {
        mark_cell($matrix, $row, $column + 1, $block);
    }
}

sub get_largest_contiguous_block {
    my $matrix = [ map { [ map { [ $_, 0] } @$_ ] } @{$_[0]} ];
    my $block = 1;
    my %sizes;
    foreach my $row (0..$#$matrix) {
        foreach my $column (0..$#{ $matrix->[0] }) {
            unless ($matrix->[$row][$column][1]) {
                mark_cell($matrix, $row, $column, $block++)
            }
            ++$sizes{ $matrix->[$row][$column][1] };
        }
    }
    return (sort { $b <=> $a } values %sizes)[0];
}

my $example1 = [
    [ 'x', 'x', 'x', 'x', 'o' ],
    [ 'x', 'o', 'o', 'o', 'o' ],
    [ 'x', 'o', 'o', 'o', 'o' ],
    [ 'x', 'x', 'x', 'o', 'o' ],
];

my $example2 = [
    [ 'x', 'x', 'x', 'x', 'x' ],
    [ 'x', 'o', 'o', 'o', 'o' ],
    [ 'x', 'x', 'x', 'x', 'o' ],
    [ 'x', 'o', 'o', 'o', 'o' ],
];

my $example3 = [
    [ 'x', 'x', 'x', 'o', 'o' ],
    [ 'o', 'o', 'o', 'x', 'x' ],
    [ 'o', 'x', 'x', 'o', 'o' ],
    [ 'o', 'o', 'o', 'x', 'x' ],
];

is(get_largest_contiguous_block($example1), 11);
is(get_largest_contiguous_block($example2), 11);
is(get_largest_contiguous_block($example3), 7);
