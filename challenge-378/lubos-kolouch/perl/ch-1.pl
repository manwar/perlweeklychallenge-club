#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Second Largest Digit

=head1 DESCRIPTION

You are given an alphanumeric string.
Write a script to find the second largest distinct digit in the given string. Return -1 if none found.

=cut

sub second_largest_digit ($str) {
    my @digits = $str =~ /(\d)/g;
    my %seen;
    my @unique_digits = sort { $b <=> $a } grep { !$seen{$_}++ } @digits;
    if (scalar @unique_digits >= 2) {
        return int($unique_digits[1]);
    }
    return -1;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'aaaaa77777', expected => -1 },
        { label => 'Example 2', str => 'abcde', expected => -1 },
        { label => 'Example 3', str => '9zero8eight7seven9', expected => 8 },
        { label => 'Example 4', str => 'xyz9876543210', expected => 8 },
        { label => 'Example 5', str => '4abc4def2ghi8jkl2', expected => 4 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = second_largest_digit($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
