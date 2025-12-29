#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Min Abs Diff

=head1 SYNOPSIS

  perl ch-1.pl 4 2 1 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of distinct integers, find all pairs C<[a,b]> such that C<a<b>
and C<b-a> equals the minimum absolute difference among all element pairs.

Sorting makes the minimum absolute difference occur between adjacent elements;
we collect all adjacent pairs achieving that minimum.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub min_abs_diff_pairs ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    return [] if @$ints < 2;

    my @sorted = sort { $a <=> $b } @$ints;
    my $min_diff = undef;

    for my $i ( 1 .. $#sorted ) {
        my $diff = $sorted[$i] - $sorted[ $i - 1 ];
        $min_diff = $diff if !defined($min_diff) || $diff < $min_diff;
    }

    my @pairs;
    for my $i ( 1 .. $#sorted ) {
        my $diff = $sorted[$i] - $sorted[ $i - 1 ];
        push @pairs, [ $sorted[ $i - 1 ], $sorted[$i] ] if $diff == $min_diff;
    }

    return \@pairs;
}

sub _render_pairs ($pairs) {
    return join ', ', map { '[' . $_->[0] . ', ' . $_->[1] . ']' } @$pairs;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints  = map { 0 + $_ } @args;
    my $pairs = min_abs_diff_pairs( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say 'Output: ' . _render_pairs($pairs);
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 4, 2, 1, 3 ],          expected => [ [ 1, 2 ], [ 2, 3 ], [ 3, 4 ] ] },
        { label => 'Example 2', ints => [ 10, 100, 20, 30 ],     expected => [ [ 10, 20 ], [ 20, 30 ] ] },
        { label => 'Example 3', ints => [ -5, -2, 0, 3 ],        expected => [ [ -2, 0 ] ] },
        { label => 'Example 4', ints => [ 8, 1, 15, 3 ],         expected => [ [ 1, 3 ] ] },
        { label => 'Example 5', ints => [ 12, 5, 9, 1, 15 ],     expected => [ [ 9, 12 ], [ 12, 15 ] ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = min_abs_diff_pairs( $case->{ints} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 min_abs_diff_pairs($ints)

Returns an array reference of C<[a,b]> pairs whose difference equals the
minimum absolute difference in the list.

=cut
