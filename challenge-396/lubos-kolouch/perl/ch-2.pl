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

ch-2.pl - Trionic Array (WWC 396 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 1 3 5 4 2 6 8
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to return 'true' if the given array is Trionic, otherwise return 'false'.
An array is trionic if there exist indices 0 < p < q < n - 1 such that:
- arr[0..p] is strictly increasing
- arr[p..q] is strictly decreasing
- arr[q..n - 1] is strictly increasing

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub is_trionic ($arr) {
    ($arr) = $INTS_CHECK->($arr);
    my $n = scalar @$arr;
    return 'false' if $n < 4;

    my $i = 0;

    # Phase 1: Strictly increasing up to peak p (must have at least one step)
    while ( $i + 1 < $n && $arr->[$i] < $arr->[ $i + 1 ] ) {
        $i++;
    }

    # If no increase or increased all the way to the end
    my $p = $i;
    return 'false' if $p == 0 || $p >= $n - 2;

    # Phase 2: Strictly decreasing down to valley q (must have at least one step)
    while ( $i + 1 < $n && $arr->[$i] > $arr->[ $i + 1 ] ) {
        $i++;
    }

    my $q = $i;
    return 'false' if $q == $p || $q >= $n - 1;

    # Phase 3: Strictly increasing to the end (must reach n - 1)
    while ( $i + 1 < $n && $arr->[$i] < $arr->[ $i + 1 ] ) {
        $i++;
    }

    return $i == $n - 1 ? 'true' : 'false';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = is_trionic( \@ints );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', arr => [ 1, 3, 5, 4, 2, 6, 8 ], expected => 'true' },
        { label => 'Example 2', arr => [ 1, 4, 4, 2, 1, 3, 5 ], expected => 'false' },
        { label => 'Example 3', arr => [ 2, 10, 3, 1, 9 ],       expected => 'true' },
        { label => 'Example 4', arr => [ 1, 2, 3, 4, 3, 2, 1 ], expected => 'false' },
        { label => 'Example 5', arr => [ 1, 3, 2, 4, 1, 5, 2 ], expected => 'false' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( is_trionic( $case->{arr} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_trionic(\@arr)

Returns 'true' if the array follows the increasing-decreasing-increasing trionic pattern, 'false' otherwise.

=cut
