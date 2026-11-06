#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Product Sign (The Weekly Challenge 267 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl -1 -2 -3 -4 3 2 1
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.

Write a script to return:
- C<1> if the product of all integers is positive
- C<-1> if the product of all integers is negative
- C<0> if the product of all integers is zero

=head1 FUNCTIONS

=head2 product_sign($ints_ref)

Computes the sign of the product of an array reference of integers.

=over 4

=item * C<$ints_ref> - Reference to an array of integers.

=back

Returns C<1>, C<-1>, or C<0>.

=cut

signature_for product_sign => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub product_sign ($ints_ref) {
    my $negative_count = 0;

    for my $value (@$ints_ref) {
        return 0 if $value == 0;
        $negative_count++ if $value < 0;
    }

    return $negative_count % 2 == 0 ? 1 : -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = product_sign( \@ints );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', ints => [ -1, -2, -3, -4, 3, 2, 1 ], expected => 1 },
        { label => 'Example 2', ints => [ 1, 2, 0, -2, -1 ],         expected => 0 },
        { label => 'Example 3', ints => [ -1, -1, 1, -1, 2 ],        expected => -1 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( product_sign( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
