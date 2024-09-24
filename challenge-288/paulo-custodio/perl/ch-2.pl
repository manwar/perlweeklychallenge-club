#!/usr/bin/env perl

# Challenge 288
#
# Task 2: Contiguous Block
# Submitted by: Peter Campbell Smith
# You are given a rectangular matrix where all the cells contain either x or o.
#
# Write a script to determine the size of the largest contiguous block.
#
# A contiguous block consists of elements containing the same symbol which
# share an edge (not just a corner) with other elements in the block, and where
# there is a path between any two of these elements that crosses only those
# shared edges.
#
# Example 1
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'x', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'x', 'x', 'o', 'o'],
#                      ]
#     Ouput: 11
#
#         There is a block of 9 contiguous cells containing 'x'.
#         There is a block of 11 contiguous cells containing 'o'.
# Example 2
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'x', 'x'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                        ['x', 'x', 'x', 'x', 'o'],
#                        ['x', 'o', 'o', 'o', 'o'],
#                      ]
#     Ouput: 11
#
#         There is a block of 11 contiguous cells containing 'x'.
#         There is a block of 9 contiguous cells containing 'o'.
# Example 3
#     Input: $matrix = [
#                        ['x', 'x', 'x', 'o', 'o'],
#                        ['o', 'o', 'o', 'x', 'x'],
#                        ['o', 'x', 'x', 'o', 'o'],
#                        ['o', 'o', 'o', 'x', 'x'],
#                      ]
#     Ouput: 7
#
#         There is a block of 7 contiguous cells containing 'o'.
#         There are two other 2-cell blocks of 'o'.
#         There are three 2-cell blocks of 'x' and one 3-cell.

use Modern::Perl;

my $SEEN = ' ';

sub parse_matrix {
    my(@m) = @_;
    @m = map {[split //, $_]} @m;
    return @m;
}

sub size_block {
    my($m, $ch, $r, $c) = @_;
    $m->[$r][$c] = $SEEN;
    my $count = 1;
    if ($r-1 >= 0 && $m->[$r-1][$c] eq $ch) {
        $count += size_block($m, $ch, $r-1, $c);
    }
    if ($r+1 < @$m && $m->[$r+1][$c] eq $ch) {
        $count += size_block($m, $ch, $r+1, $c);
    }
    if ($c-1 >= 0 && $m->[$r][$c-1] eq $ch) {
        $count += size_block($m, $ch, $r, $c-1);
    }
    if ($c+1 < @{$m->[0]} && $m->[$r][$c+1] eq $ch) {
        $count += size_block($m, $ch, $r, $c+1);
    }
    return $count;
}

sub max_block {
    my(@m) = @_;
    my $max_block = 0;
    for my $r (0 .. @m-1) {
        for my $c (0 .. @{$m[0]}-1) {
            next if $m[$r][$c] eq $SEEN;
            my $block = size_block(\@m, $m[$r][$c], $r, $c);
            if ($block > $max_block) {
                $max_block = $block;
            }
        }
    }
    return $max_block;
}

my @m = parse_matrix(@ARGV);
my $max_block = max_block(@m);
say $max_block;
