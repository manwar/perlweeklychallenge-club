#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Count Even Digits Number (The Weekly Challenge 258 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 10 1 111 24 1000
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of positive integers, C<@ints>.
Write a script to find out how many integers have an even number of digits.

=head1 FUNCTIONS

=head2 count_even_digits($ints)

Counts how many integers in C<$ints> have an even number of digits.

=over 4

=item * C<$ints> - Array reference of positive integers.

=back

Returns the count as an integer.

=cut

signature_for count_even_digits => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub count_even_digits ($ints) {
    my $even_digits_count = 0;

    for my $num (@$ints) {
        if ( length( abs($num) ) % 2 == 0 ) {
            $even_digits_count++;
        }
    }

    return $even_digits_count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints = map { int($_) } @args;
    say count_even_digits( \@ints );
    return;
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1: (10, 1, 111, 24, 1000)',
            ints     => [ 10, 1, 111, 24, 1000 ],
            expected => 3,
        },
        {
            label    => 'Example 2: (111, 1, 11111)',
            ints     => [ 111, 1, 11111 ],
            expected => 0,
        },
        {
            label    => 'Example 3: (2, 8, 1024, 256)',
            ints     => [ 2, 8, 1024, 256 ],
            expected => 1,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( count_even_digits( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    return;
}

_run_cli(@ARGV);

=cut
