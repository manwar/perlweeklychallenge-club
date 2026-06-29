#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Reverse Degree

=head1 DESCRIPTION

You are given a string.
Write a script to find the reverse degree of the given string.
For each character, multiply its position in the reversed alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1)
with its position in the string (1-based index).
Sum these products for all characters in the string.

=cut

sub reverse_degree ($str) {
    my $sum = 0;
    my @chars = split //, lc($str);
    for my $i (0 .. $#chars) {
        my $char = $chars[$i];
        next unless $char =~ /[a-z]/;
        my $value = 26 - (ord($char) - ord('a'));
        my $position = $i + 1;
        $sum += $value * $position;
    }
    return $sum;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'z', expected => 1 },
        { label => 'Example 2', str => 'a', expected => 26 },
        { label => 'Example 3', str => 'bbc', expected => 147 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = reverse_degree($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
