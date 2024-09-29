#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';

sub find_block($matrix, $seen, $row, $col) {
    my $cols = scalar(@{$matrix->[0]});

    # The character that we need to match
    my $char = $matrix->[$row][$col];

    # The directions we can move: Up, down, left, right
    my @directions = ([-1, 0], [1, 0], [0, -1], [0, 1]);

    # Mark the we have seen the starting cell
    $seen->[$row][$col] = 1;

    # Add the starting cell to the stack
    my @stack = ([$row, $col]);
    my $count = 1;

    while ($#stack > -1) {
        # Whether we found a move from the last value in the stack
        my $new_pos = 0;

        foreach my $move (@directions) {
            # Move in each direction
            my $new_row = $stack[-1][0] + $move->[0];
            my $new_col = $stack[-1][1] + $move->[1];

            # Check that the move is still in bounds of the matrix, we haven't
            #  already use that position, and it is the correct character
            if ($new_row < 0 or $new_row > $#$matrix or $new_col < 0 or $new_col >= $cols or $seen->[$new_row][$new_col] or $matrix->[$new_row][$new_col] ne $char) {
                next;
            }

            # It is, add it to the stack, and increment the count
            push @stack, [$new_row, $new_col];
            $seen->[$new_row][$new_col] = 1;
            $new_pos = 1;
            $count++;
        }

        if (! $new_pos) {
            # We didn't find a new move, remove it from that stack.
            pop(@stack);
        }
    }

    return $count;
}

sub contiguous_block($matrix) {
    my $cols = scalar(@{$matrix->[0]});
    my $max_block = 0;

    # Seed the seen table
    my $seen = [];
    for (0 .. $#$matrix) {
        push @$seen, [ (0) x $cols ];
    }

    foreach my $row (0 .. $#$matrix) {
        foreach my $col (0 .. $cols - 1) {
            if ($seen->[$row][$col]) {
                # The item at this position has already been used
                next;
            }

            # Find how many items in this block. If greater than max_block, replace it
            my $count = find_block($matrix, $seen, $row, $col);
            if ($count > $max_block) {
                $max_block = $count;
            }
        }
    }

    say $max_block;
}

contiguous_block( decode_json( $ARGV[0] ) );