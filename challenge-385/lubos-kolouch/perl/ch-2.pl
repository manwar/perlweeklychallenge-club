#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Outermost Parentheses

=head1 DESCRIPTION

You are given a valid parentheses string.
Write a script to return the string after removing the outermost parentheses of every primitive string in the primitive decomposition of the given string.

=cut

sub remove_outermost_parentheses ($str) {
    my $result = '';
    my $depth = 0;

    for my $char (split //, $str) {
        if ($char eq '(') {
            if ($depth > 0) {
                $result .= $char;
            }
            $depth++;
        }
        elsif ($char eq ')') {
            $depth--;
            if ($depth > 0) {
                $result .= $char;
            }
        }
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
        { label => 'Example 1', str => '()()()', expected => '' },
        { label => 'Example 2', str => '(((())))', expected => '((()))' },
        { label => 'Example 3', str => '(()())(())', expected => '()()()' },
        { label => 'Example 4', str => '()((()))()', expected => '(())' },
        { label => 'Example 5', str => '(()(()))(()())', expected => '()(())()()' },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = remove_outermost_parentheses($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
