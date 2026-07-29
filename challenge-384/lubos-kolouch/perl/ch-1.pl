#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Base N

=head1 DESCRIPTION

You are given a number and a base integer.
Write a script to convert the given number in the given base integer.

=cut

sub convert_base ($num, $base) {
    die "Base must be between 2 and 64" if $base < 2 || $base > 64;
    return '0' if $num == 0;

    my $digits = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';
    my $result = '';

    while ($num > 0) {
        my $rem = $num % $base;
        $result = substr($digits, $rem, 1) . $result;
        $num = int($num / $base);
    }

    return $result;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', num => 42, base => 2, expected => '101010' },
        { label => 'Example 2', num => 15642094, base => 16, expected => 'EEADEE' },
        { label => 'Example 3', num => 493, base => 8, expected => '755' },
        { label => 'Example 4', num => 2228519, base => 36, expected => '1BRJB' },
        { label => 'Example 5', num => 123456789, base => 64, expected => '7MyqL' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = convert_base($case->{num}, $case->{base});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
