#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Sum of Frequencies

=head1 DESCRIPTION

You are given a string consisting of English letters.
Write a script to find the vowel and consonant with maximum frequency.
Return the sum of two frequencies.

=cut

sub sum_of_frequencies ($str) {
    my %vowels = map { $_ => 1 } qw(a e i o u);
    my %vowel_counts;
    my %consonant_counts;

    for my $char (split //, lc($str)) {
        next unless $char =~ /[a-z]/;
        if (exists $vowels{$char}) {
            $vowel_counts{$char}++;
        }
        else {
            $consonant_counts{$char}++;
        }
    }

    my $max_vowel = 0;
    for my $count (values %vowel_counts) {
        $max_vowel = $count if $count > $max_vowel;
    }

    my $max_consonant = 0;
    for my $count (values %consonant_counts) {
        $max_consonant = $count if $count > $max_consonant;
    }

    return $max_vowel + $max_consonant;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'banana', expected => 5 },
        { label => 'Example 2', str => 'teestett', expected => 7 },
        { label => 'Example 3', str => 'aeiouuaa', expected => 3 },
        { label => 'Example 4', str => 'rhythm', expected => 2 },
        { label => 'Example 5', str => 'x', expected => 1 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = sum_of_frequencies($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
