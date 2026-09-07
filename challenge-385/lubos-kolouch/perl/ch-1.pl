#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Uncommon Words

=head1 DESCRIPTION

You are given two sentences.
Write a script to return a list of all uncommon words, order is not important.
An uncommon word is a word that appears exactly once in total across both sentences.

=cut

sub uncommon_words ($sentence1, $sentence2) {
    my %counts;
    for my $word (split /\s+/, $sentence1) {
        $counts{$word}++;
    }
    for my $word (split /\s+/, $sentence2) {
        $counts{$word}++;
    }

    my @uncommon;
    for my $word (keys %counts) {
        if ($counts{$word} == 1) {
            push @uncommon, $word;
        }
    }

    return [sort @uncommon];
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
            s1 => 'apple banana apple',
            s2 => 'banana orange',
            expected => ['orange']
        },
        {
            label => 'Example 2',
            s1 => 'cat dog',
            s2 => 'bird fish',
            expected => ['bird', 'cat', 'dog', 'fish']
        },
        {
            label => 'Example 3',
            s1 => 'the quick brown fox',
            s2 => 'the quick',
            expected => ['brown', 'fox']
        },
        {
            label => 'Example 4',
            s1 => 'hello',
            s2 => 'hello',
            expected => []
        },
        {
            label => 'Example 5',
            s1 => 'blue blue red',
            s2 => 'red green green yellow',
            expected => ['yellow']
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = uncommon_words($case->{s1}, $case->{s2});
        Test::More::is_deeply([sort @$got], [sort @{$case->{expected}}], $case->{label});
    }
}

_run_cli(@ARGV);
