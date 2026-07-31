#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Special Binary Substrings

=head1 DESCRIPTION

You are given a binary string.
Write a script to return all non-empty substrings (distinct) that have the same number of 0's and 1's, and all the 0's and all the 1's in these substrings are grouped consecutively.

=cut

sub special_binary_substrings ($binary) {
    my $len = length($binary);
    my %matches;

    for (my $k = 1; $k <= int($len / 2); $k++) {
        my $pattern1 = ('0' x $k) . ('1' x $k);
        my $pattern2 = ('1' x $k) . ('0' x $k);

        if (index($binary, $pattern1) != -1) {
            $matches{$pattern1} = 1;
        }
        if (index($binary, $pattern2) != -1) {
            $matches{$pattern2} = 1;
        }
    }

    return [sort keys %matches];
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
            binary => '0101',
            expected => ['01', '10']
        },
        {
            label => 'Example 2',
            binary => '000111',
            expected => ['000111', '0011', '01']
        },
        {
            label => 'Example 3',
            binary => '000011',
            expected => ['0011', '01']
        },
        {
            label => 'Example 4',
            binary => '10011100',
            expected => ['0011', '01', '10', '1100']
        },
        {
            label => 'Example 5',
            binary => '00000',
            expected => []
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = special_binary_substrings($case->{binary});
        Test::More::is_deeply([sort @$got], [sort @{$case->{expected}}], $case->{label});
    }
}

_run_cli(@ARGV);
