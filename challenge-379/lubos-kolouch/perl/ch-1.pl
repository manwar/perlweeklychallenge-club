#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Reverse String

=head1 DESCRIPTION

You are given a string.
Write a script to reverse the given string without using the standard reverse function.

=cut

sub reverse_string ($str) {
    my $reversed = "";
    for my $char (split //, $str) {
        $reversed = $char . $reversed;
    }
    return $reversed;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'weekly', expected => 'ylkeew' },
        { label => 'Example 2', str => 'challenge', expected => 'egnellahc' },
        { label => 'Example 3', str => '12345', expected => '54321' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = reverse_string($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
