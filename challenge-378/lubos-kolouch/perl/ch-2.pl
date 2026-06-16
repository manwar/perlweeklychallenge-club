#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Sum of Words

=head1 DESCRIPTION

You are given three strings consisting of lower case English letters ‘a’ to ‘j’ only.
The letter value of a = 0, b = 1, c = 2, etc.
Write a script to find if sum of first two strings return the third string.

=cut

sub word_to_num ($word) {
    my $num_str = "";
    for my $char (split //, $word) {
        $num_str .= ord($char) - ord('a');
    }
    return int($num_str);
}

sub sum_of_words ($str1, $str2, $str3) {
    my $n1 = word_to_num($str1);
    my $n2 = word_to_num($str2);
    my $n3 = word_to_num($str3);
    return ($n1 + $n2 == $n3) ? 1 : 0;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', s1 => 'acb',  s2 => 'cba',  s3 => 'cdb',  expected => 1 },
        { label => 'Example 2', s1 => 'aab',  s2 => 'aac',  s3 => 'ad',   expected => 1 },
        { label => 'Example 3', s1 => 'bc',   s2 => 'je',   s3 => 'jg',   expected => 0 },
        { label => 'Example 4', s1 => 'a',    s2 => 'aaaa', s3 => 'aa',   expected => 1 },
        { label => 'Example 5', s1 => 'c',    s2 => 'd',    s3 => 'h',    expected => 0 },
        { label => 'Example 6', s1 => 'gfi',  s2 => 'hbf',  s3 => 'bdhd', expected => 1 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = sum_of_words($case->{s1}, $case->{s2}, $case->{s3});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
