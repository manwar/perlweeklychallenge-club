#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Chessboard Squares

=head1 DESCRIPTION

You are given two coordinates of a square on an 8x8 chessboard.
Write a script to find if the given two coordinates have the same colour.

=cut

sub square_color_parity ($coord) {
    die "Invalid coordinate format" unless $coord =~ /^([a-h])([1-8])$/;
    my ($col, $row) = ($1, $2);
    my $col_num = ord($col) - ord('a') + 1;
    return ($col_num + $row) % 2;
}

sub same_color ($c1, $c2) {
    return square_color_parity($c1) == square_color_parity($c2) ? 1 : 0;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', c1 => 'a7', c2 => 'f4', expected => 1 },
        { label => 'Example 2', c1 => 'c1', c2 => 'e8', expected => 0 },
        { label => 'Example 3', c1 => 'b5', c2 => 'h2', expected => 0 },
        { label => 'Example 4', c1 => 'f3', c2 => 'h1', expected => 1 },
        { label => 'Example 5', c1 => 'a1', c2 => 'g8', expected => 0 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = same_color($case->{c1}, $case->{c2});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
