#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use List::Util qw(min max);
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Smaller Greater Element

=head1 DESCRIPTION

You are given an array of integers.
Write a script to find the number of elements that have both a strictly smaller and greater element in the given array.

=cut

sub smaller_greater_element ($arr) {
    return 0 if scalar @$arr < 3;

    my $min = min @$arr;
    my $max = max @$arr;

    my $count = 0;
    for my $val (@$arr) {
        $count++ if $val > $min && $val < $max;
    }

    return $count;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', arr => [2, 4], expected => 0 },
        { label => 'Example 2', arr => [1, 1, 1, 1], expected => 0 },
        { label => 'Example 3', arr => [1, 1, 4, 8, 12, 12], expected => 2 },
        { label => 'Example 4', arr => [3, 6, 6, 9], expected => 2 },
        { label => 'Example 5', arr => [0, -5, 10, -2, 4], expected => 3 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = smaller_greater_element($case->{arr});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
