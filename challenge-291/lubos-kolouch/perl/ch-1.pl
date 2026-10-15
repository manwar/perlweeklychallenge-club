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

ch-1.pl - Middle Index (WWC 291 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 2 3 -1 8 4
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to find the leftmost index where the sum of numbers to its left
equals the sum of numbers to its right. If no such index exists, return -1.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub find_middle_index ($ints) {
    ($ints) = $INTS_CHECK->($ints);
    return -1 if !@$ints;

    my $total_sum = 0;
    $total_sum += $_ for @$ints;

    my $left_sum = 0;

    for my $i ( 0 .. $#$ints ) {
        my $right_sum = $total_sum - $left_sum - $ints->[$i];

        if ( $left_sum == $right_sum ) {
            return $i;
        }

        $left_sum += $ints->[$i];
    }

    return -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = find_middle_index( \@ints );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 2, 3, -1, 8, 4 ], expected => 3 },
        { label => 'Example 2', ints => [ 1, -1, 4 ],        expected => 2 },
        { label => 'Example 3', ints => [ 2, 5 ],            expected => -1 },
        { label => 'Single element', ints => [0],            expected => 0 },
        { label => 'Empty array',    ints => [],             expected => -1 },
        { label => 'Zero at start',  ints => [ 0, 1, -1 ],   expected => 0 },
        { label => 'Zero at end',    ints => [ 1, -1, 0 ],   expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( find_middle_index( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 find_middle_index(\@ints)

Returns the leftmost index where sum of elements on left equals sum on right, or -1.

=cut
