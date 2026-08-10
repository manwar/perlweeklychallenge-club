#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
use List::Util qw(any);
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Similar List

=head1 DESCRIPTION

You are given three list of strings.
Write a script to find out if the first two list are similar with the help the third list. The third list contains the similar words map.

=cut

sub are_similar_lists ($list1, $list2, $list3) {
    return 0 if scalar @$list1 != scalar @$list2;

    for (my $i = 0; $i < scalar @$list1; $i++) {
        my $w1 = $list1->[$i];
        my $w2 = $list2->[$i];

        next if $w1 eq $w2;

        # Check if there is any list in $list3 containing both $w1 and $w2
        my $found = 0;
        for my $map_list (@$list3) {
            my %map_set = map { $_ => 1 } @$map_list;
            if (exists $map_set{$w1} && exists $map_set{$w2}) {
                $found = 1;
                last;
            }
        }
        return 0 unless $found;
    }

    return 1;
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
            list1 => ["great", "acting"],
            list2 => ["fine", "drama"],
            list3 => [["great", "fine"], ["acting", "drama"]],
            expected => 1
        },
        {
            label => 'Example 2',
            list1 => ["apple", "pie"],
            list2 => ["banana", "pie"],
            list3 => [["apple", "peach"], ["peach", "banana"]],
            expected => 0
        },
        {
            label => 'Example 3',
            list1 => ["perl4", "python"],
            list2 => ["raku", "python"],
            list3 => [["perl4", "perl5", "raku"]],
            expected => 1
        },
        {
            label => 'Example 4',
            list1 => ["enjoy", "challenge"],
            list2 => ["love", "weekly", "challenge"],
            list3 => [["enjoy", "love"]],
            expected => 0
        },
        {
            label => 'Example 5',
            list1 => ["fast", "car"],
            list2 => ["quick", "vehicle"],
            list3 => [["quick", "fast"], ["vehicle", "car"]],
            expected => 1
        },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = are_similar_lists($case->{list1}, $case->{list2}, $case->{list3});
        Test::More::is($got, $case->{expected}, $case->{label});
    }
}

_run_cli(@ARGV);
