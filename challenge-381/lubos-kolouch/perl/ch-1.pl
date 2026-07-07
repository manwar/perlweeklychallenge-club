#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Same Row Column

=head1 DESCRIPTION

You are given a n x n matrix containing integers from 1 to n.
Write a script to find if every row and every column contains all the integers from 1 to n.

=cut

sub same_row_column ($matrix) {
    my $n = scalar @$matrix;

    # Check rows
    for my $row (@$matrix) {
        return 0 if scalar @$row != $n;
        my %seen;
        for my $val (@$row) {
            return 0 if $val < 1 || $val > $n || $seen{$val}++;
        }
    }

    # Check columns
    for my $col_idx (0 .. $n - 1) {
        my %seen;
        for my $row_idx (0 .. $n - 1) {
            my $val = $matrix->[$row_idx][$col_idx];
            return 0 if $val < 1 || $val > $n || $seen{$val}++;
        }
    }

    return 1;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label => 'Example 1',
            matrix => [
                [1, 2, 3, 4],
                [2, 3, 4, 1],
                [3, 4, 1, 2],
                [4, 1, 2, 3]
            ],
            expected => 1
        },
        {
            label => 'Example 2',
            matrix => [[1]],
            expected => 1
        },
        {
            label => 'Example 3',
            matrix => [
                [1, 2, 5],
                [5, 1, 2],
                [2, 5, 1]
            ],
            expected => 0
        },
        {
            label => 'Example 4',
            matrix => [
                [1, 2, 3],
                [1, 2, 3],
                [1, 2, 3]
            ],
            expected => 0
        },
        {
            label => 'Example 5',
            matrix => [
                [1, 2, 3],
                [3, 1, 2],
                [3, 2, 1]
            ],
            expected => 0
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = same_row_column($case->{matrix});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
