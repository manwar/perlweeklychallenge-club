#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(uniq);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Rank Array

=head1 SYNOPSIS

  perl ch-2.pl 55 22 44 33
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Assigns ranks to the elements of an integer array: the lowest value has rank 1,
the next distinct value rank 2, and so on. Equal values share the same rank.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub rank_array ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    return [] if !@$ints;

    my @sorted_unique = sort { $a <=> $b } uniq(@$ints);
    my %rank_of;
    for my $idx ( 0 .. $#sorted_unique ) {
        $rank_of{ $sorted_unique[$idx] } = $idx + 1;
    }

    return [ map { $rank_of{$_} } @$ints ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints = map { 0 + $_ } @args;
    my $ranks = rank_array( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say 'Output: (' . join( ', ', @$ranks ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 55, 22, 44, 33 ], expected => [ 4, 1, 3, 2 ] },
        { label => 'Example 2', ints => [ 10, 10, 10 ],     expected => [ 1, 1, 1 ] },
        { label => 'Example 3', ints => [ 5, 1, 1, 4, 3 ],  expected => [ 4, 1, 1, 3, 2 ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = rank_array( $case->{ints} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 rank_array($ints)

Returns an array reference of ranks corresponding to the input values.

=cut
