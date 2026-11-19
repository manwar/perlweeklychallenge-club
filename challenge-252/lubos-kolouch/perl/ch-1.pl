#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params    -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Special Numbers (PWC 252 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 4
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.
Write a script to find the sum of the squares of all special elements of the given array.
An element C<$ints[i]> (1-indexed) is special if C<i> divides C<n>, where C<n> is the
length of the array.

=cut

my $check_ints = signature( positional => [ ArrayRef [Int] ] );

sub sum_of_special_squares ($ints) {
    ($ints) = $check_ints->($ints);
    my $n   = scalar @{$ints};
    my $sum = 0;

    for my $i ( 1 .. $n ) {
        $sum += $ints->[ $i - 1 ]**2 if $n % $i == 0;
    }

    return $sum;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    say 'Output: ' . sum_of_special_squares( \@ints );
    return;
}

sub _run_tests () {
    my @cases = (
        { label => 'Example 1',      ints => [ 1, 2, 3, 4 ],         expected => 21 },
        { label => 'Example 2',      ints => [ 2, 7, 1, 19, 18, 3 ], expected => 63 },
        { label => 'Single element', ints => [5],                    expected => 25 },
        { label => 'Empty array',    ints => [],                     expected => 0 },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is( sum_of_special_squares( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    return;
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 sum_of_special_squares(\@ints)

Returns the sum of squares of all 1-indexed elements whose index divides C<scalar @ints>.

=cut
