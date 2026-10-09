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

ch-2.pl - Next Permutation (WWC 294 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 1 2 3
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to rearrange the numbers into the lexicographically next greater permutation.
If no greater permutation is possible, rearrange them into the lowest possible order (sorted ascending).

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub next_permutation ($ints_ref) {
    ($ints_ref) = $INTS_CHECK->($ints_ref);
    my @ints = @$ints_ref;
    my $n    = scalar @ints;
    return \@ints if $n <= 1;

    # Step 1: Find the largest index i such that ints[i] < ints[i + 1]
    my $i = $n - 2;
    while ( $i >= 0 && $ints[$i] >= $ints[ $i + 1 ] ) {
        $i--;
    }

    if ( $i < 0 ) {
        # The given permutation is the last; return sorted ascending
        @ints = sort { $a <=> $b } @ints;
        return \@ints;
    }

    # Step 2: Find the largest index j > i such that ints[i] < ints[j]
    my $j = $n - 1;
    while ( $ints[$j] <= $ints[$i] ) {
        $j--;
    }

    # Step 3: Swap ints[i] and ints[j]
    ( $ints[$i], $ints[$j] ) = ( $ints[$j], $ints[$i] );

    # Step 4: Reverse the sub-array from ints[i + 1] to the end
    my @suffix = reverse @ints[ $i + 1 .. $n - 1 ];
    splice @ints, $i + 1, $n - ( $i + 1 ), @suffix;

    return \@ints;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = next_permutation( \@ints );
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 2, 3 ], expected => [ 1, 3, 2 ] },
        { label => 'Example 2', ints => [ 2, 1, 3 ], expected => [ 2, 3, 1 ] },
        { label => 'Example 3', ints => [ 3, 1, 2 ], expected => [ 3, 2, 1 ] },
        { label => 'Example 4', ints => [ 3, 2, 1 ], expected => [ 1, 2, 3 ] },
        { label => 'Example 5', ints => [ 1, 1, 5 ], expected => [ 1, 5, 1 ] },
        { label => 'Example 6', ints => [ 1, 5, 1 ], expected => [ 5, 1, 1 ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = next_permutation( $case->{ints} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 next_permutation(\@ints)

Returns the lexicographically next greater permutation (or sorted ascending if last).

=cut
