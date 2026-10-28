#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Third Distinct Maximum (The Weekly Challenge 289 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 5 6 4 1
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of integers, returns the third distinct maximum number.
If the third maximum does not exist, returns the maximum number.

=head1 FUNCTIONS

=head2 third_distinct_maximum(\@ints)

Given an array reference of integers, returns the third distinct maximum number.
If it doesn't exist, returns the maximum number.

=cut

signature_for third_distinct_maximum => (
    method     => 0,
    positional => [ ArrayRef[Int] ],
);

sub third_distinct_maximum ($ints_ref) {
    my %seen;
    my @distinct_descending = sort { $b <=> $a } grep { !$seen{$_}++ } @$ints_ref;

    if (@distinct_descending >= 3) {
        return $distinct_descending[2];
    } else {
        return $distinct_descending[0];
    }
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = third_distinct_maximum( \@ints );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', ints => [ 5, 6, 4, 1 ],     expected => 4 },
        { label => 'Example 2', ints => [ 4, 5 ],           expected => 5 },
        { label => 'Example 3', ints => [ 1, 2, 2, 3 ],     expected => 1 },
        { label => 'Single elem', ints => [ 10 ],           expected => 10 },
        { label => 'Negative nums', ints => [ -1, -2, -3, -4 ], expected => -3 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( third_distinct_maximum( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
