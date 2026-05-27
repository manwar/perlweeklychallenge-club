#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Single Common Word

=head1 DESCRIPTION

Given two arrays of strings, return the number of strings that appear exactly once
in each of the two given arrays (case-sensitive comparison).

=cut

sub single_common_word ($arr1_ref, $arr2_ref) {
    die "First argument must be an array reference" unless ref($arr1_ref) eq 'ARRAY';
    die "Second argument must be an array reference" unless ref($arr2_ref) eq 'ARRAY';

    my %count1;
    my %count2;

    $count1{$_}++ for @$arr1_ref;
    $count2{$_}++ for @$arr2_ref;

    my $count = 0;
    for my $word (keys %count1) {
        if ($count1{$word} == 1 && ($count2{$word} // 0) == 1) {
            $count++;
        }
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
        {
            label => 'Example 1',
            arr1 => ["apple", "banana", "cherry"],
            arr2 => ["banana", "cherry", "date"],
            expected => 2
        },
        {
            label => 'Example 2',
            arr1 => ["a", "ab", "abc"],
            arr2 => ["a", "a", "ab", "abc"],
            expected => 2
        },
        {
            label => 'Example 3',
            arr1 => ["Hello", "world"],
            arr2 => ["hello", "world"],
            expected => 1
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = single_common_word($case->{arr1}, $case->{arr2});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
