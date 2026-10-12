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

ch-1.pl - Twice Largest (WWC 292 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 2 4 1 0
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to determine whether the largest element in the array is at least twice
as much as every other element. If it is, return its index; otherwise, return -1.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub twice_largest_index ($ints) {
    ($ints) = $INTS_CHECK->($ints);
    return -1 if !@$ints;
    return 0  if @$ints == 1;

    my $max_val   = $ints->[0];
    my $max_index = 0;

    for my $i ( 1 .. $#$ints ) {
        if ( $ints->[$i] > $max_val ) {
            $max_val   = $ints->[$i];
            $max_index = $i;
        }
    }

    for my $i ( 0 .. $#$ints ) {
        next if $i == $max_index;
        return -1 if $max_val < 2 * $ints->[$i];
    }

    return $max_index;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = twice_largest_index( \@ints );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 2, 4, 1, 0 ], expected => 1 },
        { label => 'Example 2', ints => [ 1, 2, 3, 4 ], expected => -1 },
        { label => 'Example 3', ints => [ 5, 1, 2, 3 ], expected => -1 },
        { label => 'Example 4', ints => [1],           expected => 0 },
        { label => 'Example 5', ints => [ 0, 0, 0, 1 ], expected => 3 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( twice_largest_index( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 twice_largest_index(\@ints)

Returns the index of the largest element if it is at least twice every other element, or -1.

=cut
