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

ch-2.pl - Semi-Ordered Permutation (WWC 297 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a 0-indexed permutation of n integers nums.
A permutation is called semi-ordered if the first number equals 1 and the last
number equals n. You can make the permutation semi-ordered using adjacent swaps.
Return the minimum number of adjacent swaps.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub minimum_swaps ($ints) {
    ($ints) = $INTS_CHECK->($ints);
    my $n = scalar @$ints;
    return 0 if $n <= 1;

    my ( $pos1, $posn );
    for my $i ( 0 .. $#$ints ) {
        $pos1 = $i if $ints->[$i] == 1;
        $posn = $i if $ints->[$i] == $n;
    }

    die 'Permutation must contain 1 and n' if !defined $pos1 || !defined $posn;

    if ( $pos1 < $posn ) {
        return $pos1 + ( $n - 1 - $posn );
    }
    else {
        return $pos1 + ( $n - 1 - $posn ) - 1;
    }
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
        { label => 'Example 1', ints => [ 2, 1, 4, 3 ],    expected => 2 },
        { label => 'Example 2', ints => [ 2, 4, 1, 3 ],    expected => 3 },
        { label => 'Example 3', ints => [ 1, 3, 2, 4, 5 ], expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( minimum_swaps( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 minimum_swaps($ints)

Calculates the minimum number of adjacent swaps needed to make the permutation semi-ordered.

=cut
