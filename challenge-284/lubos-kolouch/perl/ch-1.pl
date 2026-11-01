#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(max);
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Lucky Integer (The Weekly Challenge 284 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 2 2 3 4
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

This script finds the lucky integer in a given array of integers.

A lucky integer is defined as an integer whose frequency in the array is equal to its value.

If there are multiple lucky integers, the largest one is returned. If no lucky integers are found, C<-1> is returned.

=head1 FUNCTIONS

=head2 find_lucky_integer($ints_ref)

Given an array reference of integers, returns the lucky integer as per the problem definition.

=over 4

=item * C<$ints_ref> - Reference to an array of integers.

=back

Returns the largest lucky integer if found, otherwise C<-1>.

=cut

signature_for find_lucky_integer => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub find_lucky_integer ($ints_ref) {
    my %freq;

    for my $num (@$ints_ref) {
        $freq{$num}++;
    }

    my @lucky_integers;
    for my $num ( keys %freq ) {
        if ( $num == $freq{$num} ) {
            push @lucky_integers, int($num);
        }
    }

    if (@lucky_integers) {
        return max(@lucky_integers);
    }
    return -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = find_lucky_integer( \@ints );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1',       ints => [ 2, 2, 3, 4 ],       expected => 2 },
        { label => 'Example 2',       ints => [ 1, 2, 2, 3, 3, 3 ], expected => 3 },
        { label => 'Example 3',       ints => [ 1, 1, 1, 3 ],       expected => -1 },
        { label => 'All same number', ints => [ 5, 5, 5, 5, 5 ],    expected => 5 },
        { label => 'Empty list',      ints => [],                   expected => -1 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( find_lucky_integer( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
