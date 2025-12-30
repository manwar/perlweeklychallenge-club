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

ch-2.pl - Nested Array

=head1 SYNOPSIS

  perl ch-2.pl 5 4 0 3 1 6 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a permutation array ints[0..n-1], define set[i] as the sequence
ints[i], ints[ints[i]], ints[ints[ints[i]]], ... stopping before repetition.
Return the maximum size among all set[i].

This is the longest cycle length in the permutation graph.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub nested_array_max ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    my $n = scalar @$ints;
    return 0 if $n == 0;

    my @visited = (0) x $n;
    my $best    = 0;

    for my $i ( 0 .. $n - 1 ) {
        next if $visited[$i];
        my $cur = $i;
        my %seen_in_walk;
        my $len = 0;
        while ( !$visited[$cur] && !$seen_in_walk{$cur}++ ) {
            ++$len;
            $cur = $ints->[$cur];
        }

        # Mark the entire component as visited by walking again from i.
        $cur = $i;
        while ( !$visited[$cur] ) {
            $visited[$cur] = 1;
            $cur           = $ints->[$cur];
        }

        $best = $len if $len > $best;
    }

    return $best;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = nested_array_max( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 5, 4, 0, 3, 1, 6, 2 ], expected => 4 },
        { label => 'Example 2', ints => [ 0, 1, 2 ],             expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( nested_array_max( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 nested_array_max($ints)

Returns the maximum length of the generated set[i] sequences.

=cut
