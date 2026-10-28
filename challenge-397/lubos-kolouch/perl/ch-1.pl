#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use POSIX           qw(floor);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Absent Smallest Positive (WWC 397 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 4 5 6
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to return the smallest absent positive integer such that it is
strictly greater than the average of all elements in the given array.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub absent_smallest_positive ($arr) {
    ($arr) = $INTS_CHECK->($arr);
    die 'Array cannot be empty' if !@$arr;

    my $sum = 0;
    $sum += $_ for @$arr;
    my $avg = $sum / scalar(@$arr);

    my %lookup = map { $_ => 1 } @$arr;

    # Smallest positive integer strictly greater than avg
    # If avg < 0, floor(avg) + 1 could be <= 0, but candidates must be positive (>= 1)
    my $candidate = floor($avg) + 1;
    $candidate = 1 if $candidate < 1;

    # Ensure strictly greater (in case avg was an exact integer)
    if ( $candidate <= $avg ) {
        $candidate++;
    }

    while ( exists $lookup{$candidate} ) {
        $candidate++;
    }

    return $candidate;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @arr = map { int($_) } @args;
    my $out = absent_smallest_positive( \@arr );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', arr => [ 1, 2, 4, 5, 6 ], expected => 7 },
        { label => 'Example 2', arr => [ -5, -2, -1, 3 ], expected => 1 },
        { label => 'Example 3', arr => [ 1, 2, 3 ],       expected => 4 },
        { label => 'Example 4', arr => [ 2, 3, 7, 8 ],    expected => 6 },
        { label => 'Example 5', arr => [ 1, 1, 1, 10 ],   expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( absent_smallest_positive( $case->{arr} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 absent_smallest_positive(\@arr)

Returns the smallest absent positive integer strictly greater than the average of @arr.

=cut
