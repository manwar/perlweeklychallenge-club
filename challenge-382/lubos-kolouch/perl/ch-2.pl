#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Replace Question Mark

=head1 DESCRIPTION

You are given a string that contains only 0, 1 and ? characters.
Write a script to generate all possible combinations when replacing the question marks with a zero or one.

=cut

sub replace_question_marks ($str) {
    my @results;
    _helper($str, 0, \@results);
    return [sort @results];
}

sub _helper ($str, $idx, $results) {
    if ($idx == length($str)) {
        push @$results, $str;
        return;
    }

    if (substr($str, $idx, 1) eq '?') {
        my $str0 = $str;
        substr($str0, $idx, 1, '0');
        _helper($str0, $idx + 1, $results);

        my $str1 = $str;
        substr($str1, $idx, 1, '1');
        _helper($str1, $idx + 1, $results);
    } else {
        _helper($str, $idx + 1, $results);
    }
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
            str => '01??0',
            expected => ['01000', '01010', '01100', '01110']
        },
        {
            label => 'Example 2',
            str => '101',
            expected => ['101']
        },
        {
            label => 'Example 3',
            str => '???',
            expected => ['000', '001', '010', '011', '100', '101', '110', '111']
        },
        {
            label => 'Example 4',
            str => '1?10',
            expected => ['1010', '1110']
        },
        {
            label => 'Example 5',
            str => '1?1?0',
            expected => ['10100', '10110', '11100', '11110']
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = replace_question_marks($case->{str});
        Test::More::is_deeply($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
