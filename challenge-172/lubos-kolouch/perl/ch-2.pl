#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Five-number Summary

=head1 SYNOPSIS

  perl ch-2.pl 0 1 2 3 4 5 6 7 8 9 10
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of integers, compute and print the five-number summary:
minimum, lower quartile (Q1), median (Q2), upper quartile (Q3), maximum.

Uses the "inclusive" quartile method common in statistics.

=cut

my $ARR_CHECK = compile( ArrayRef[Int] );

sub quantile ($p, @sorted) {
    my $n = @sorted;
    my $pos = $p * ($n - 1);
    my $k = int $pos;
    my $f = $pos - $k;
    return $sorted[$k] + $f * ($sorted[$k + 1] - $sorted[$k]) if $f > 0;
    return $sorted[$k];
}

sub five_number_summary ($ints) {
    ($ints) = $ARR_CHECK->($ints);
    my @sorted = sort { $a <=> $b } @$ints;
    my $n = @sorted;
    die "Array must be non-empty\n" if $n == 0;

    my $min = $sorted[0];
    my $q1  = quantile(0.25, @sorted);
    my $med = quantile(0.50, @sorted);
    my $q3  = quantile(0.75, @sorted);
    my $max = $sorted[-1];

    return ($min, $q1, $med, $q3, $max);
}

sub _run_cli (@args) {
    if (!@args) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my @summary = five_number_summary(\@ints);
    say 'Input:  @ints = (' . join(', ', @ints) . ')';
    say 'Output: (' . join(', ', @summary) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Wikipedia Example', ints => [6,7,15,36,39,40,41,42,43,47,49], expected => [6, 25.5, 40, 42.5, 49] },
        { label => 'Even length',      ints => [0,1,2,3,4,5,6,7,8,9,10], expected => [0, 2.5, 5, 7.5, 10] },
        { label => 'Odd length',       ints => [1,2,3,4,5], expected => [1, 2, 3, 4, 5] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is_deeply( [five_number_summary($case->{ints})], $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 five_number_summary($ints)

Returns a list of five numbers: min, Q1, median, Q3, max.

=cut
