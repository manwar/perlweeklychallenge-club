#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-2.pl - Doubled Words

=head1 DESCRIPTION

Given a string (which may contain embedded newlines), find doubled words
(such as "this this") and highlight (wrap in brackets) each doubled word.
Only show lines containing doubled words.

=cut

sub highlight_doubled_words ($str) {
    # Perform global case-insensitive match for doubled words separated by spaces and/or HTML tags.
    # We use a non-destructive regex copy or just modify $str
    my $modified = $str;
    $modified =~ s/\b(\w+)\b(\s*(?:<[^>]*>\s*)*)\b(\1)\b/"[$1]" . $2 . "[$3]"/gie;

    # Split into lines
    my @lines = split /\n/, $modified;

    # Only keep lines containing highlighted doubled words [word]
    my @kept_lines = grep { /\[\w+\]/ } @lines;

    # Join them back with newlines
    return join("\n", @kept_lines);
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
            str => "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.",
            expected => "web server for doubled words (such as '[this] [this]'), a common problem"
        },
        {
            label => 'Example 2',
            str => "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.",
            expected => "Find doubled words despite capitalization differences, such as with '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
        },
        {
            label => 'Example 3',
            str => "to make a word bold: '...it is <B>very</B> very important...'.",
            expected => "to make a word bold: '...it is <B>[very]</B> [very] important...'."
        },
        {
            label => 'Example 4',
            str => "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.",
            expected => ""
        },
        {
            label => 'Example 5',
            str => "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.",
            expected => "There's more than [one] [one] way to do it."
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = highlight_doubled_words($case->{str});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
