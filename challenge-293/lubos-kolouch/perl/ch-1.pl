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

ch-1.pl - Similar Dominoes (WWC 293 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a list of dominoes, where each domino is represented as [a, b].
Two dominoes [a, b] and [c, d] are similar if (a == c and b == d) or (a == d and b == c).
Write a script to return the count of dominoes that are similar to at least one other domino.

=cut

my $DOMINOES_CHECK = compile( ArrayRef [ ArrayRef [Int] ] );

sub count_similar_dominos ($dominos) {
    ($dominos) = $DOMINOES_CHECK->($dominos);

    my %domino_counts;
    my $count = 0;

    # Normalize dominos and count occurrences
    for my $domino (@$dominos) {
        die 'Each domino must have exactly 2 integers' if @$domino != 2;
        my ( $u, $v ) = @$domino;
        my $key = join( ',', sort { $a <=> $b } ( $u, $v ) );
        $domino_counts{$key}++;
    }

    # Identify dominos that are similar to any other
    for my $domino (@$dominos) {
        my ( $u, $v ) = @$domino;
        my $key = join( ',', sort { $a <=> $b } ( $u, $v ) );
        if ( $domino_counts{$key} > 1 ) {
            $count++;
        }
    }

    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label    => 'Example 1',
            dominos  => [ [ 1, 3 ], [ 3, 1 ], [ 2, 4 ], [ 6, 8 ] ],
            expected => 2,
        },
        {
            label    => 'Example 2',
            dominos  => [ [ 1, 2 ], [ 2, 1 ], [ 1, 1 ], [ 1, 2 ], [ 2, 2 ] ],
            expected => 3,
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( count_similar_dominos( $case->{dominos} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 count_similar_dominos(\@dominos)

Returns the count of dominoes that have at least one similar counterpart in the list.

=cut
