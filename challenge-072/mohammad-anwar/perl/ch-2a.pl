#!/usr/bin/perl

#
# Perl Weekly Challenge - 072
#
# Task #2: Lines Range
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
#

package LinesRange;

use Moo;

sub fetch {
    my ($self, $file, $a, $b) = @_;

    die "ERROR: Invalid file [$file].\n"
        unless (-e $file && -f _ && -r _ && -T _);

    open(my $F, "<", $file) || die "ERROR: Failed to open [$!]\n";
    my @lines = <$F>;
    close($F);

    my @ranges = ();
    push @ranges, $lines[$_] for --$a..--$b;

    return join "", @ranges;
}

package main;

use strict;
use warnings;

use Test2::V0 -target => 'LinesRange';

my $file = "input.txt";
my @test_cases = (
    { A => 1, B => 3, O => "L1\nL2\nL3\n" },
    { A => 2, B => 4, O => "L2\nL3\nL4\n" },
    { A => 3, B => 5, O => "L3\nL4\nL5\n" },
    { A => 4, B => 6, O => "L4\nL5\nL6\n" },
    { A => 5, B => 7, O => "L5\nL6\nL7\n" },
);

foreach my $test (@test_cases) {
    is $CLASS->fetch($file, $test->{"A"}, $test->{"B"}),
       $test->{"O"},
       "testing A=$test->{'A'}, B=$test->{'B'}";
}

done_testing;
