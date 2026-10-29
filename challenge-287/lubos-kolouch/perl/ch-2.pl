#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Valid Number (The Weekly Challenge 287 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 1.2e4
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script determines if the given string is a valid number based on specific rules.

A valid number is defined as:

=over 4

=item * An integer number followed by an optional exponent.

=item * A decimal number followed by an optional exponent.

=back

An integer number is defined with an optional sign '-' or '+' followed by digits.

=head2 Decimal Number

A decimal number is defined with an optional sign '-' or '+' followed by one of the following:

=over 4

=item * Digits followed by a dot '.'.

=item * Digits followed by a dot '.' followed by digits.

=item * A dot '.' followed by digits.

=back

=head2 Exponent

An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.

=head1 FUNCTIONS

=head2 is_valid_number($s)

Determines if the given string is a valid number. Returns 1 if valid, 0 otherwise.

=cut

signature_for is_valid_number => (
    method     => 0,
    positional => [ Str ],
);

sub is_valid_number ($s) {
    my $pattern = qr/
        ^                       # Start of string
        [+-]?                   # Optional sign
        (
            (                   # Decimal numbers
                \d+\.\d*        # Digits followed by dot and optional digits
                |
                \.\d+           # Dot followed by digits
                |
                \d+\.           # Digits followed by dot
            )
            |
            \d+                 # Integer numbers
        )
        ([eE][+-]?\d+)?         # Optional exponent
        $                       # End of string
    /x;
    return $s =~ $pattern ? 1 : 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = is_valid_number( $args[0] );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', str => '1',        expected => 1 },
        { label => 'Example 2', str => 'a',        expected => 0 },
        { label => 'Example 3', str => '.',        expected => 0 },
        { label => 'Example 4', str => '1.2e4.2',  expected => 0 },
        { label => 'Example 5', str => '-1.',      expected => 1 },
        { label => 'Example 6', str => '+1E-8',    expected => 1 },
        { label => 'Example 7', str => '.44',      expected => 1 },
        { label => 'Exponent with decimal', str => '6e6.5', expected => 0 },
        { label => 'Empty string',          str => '',      expected => 0 },
        { label => 'Integer number',        str => '123',   expected => 1 },
        { label => 'Negative dot only',     str => '-.',    expected => 0 },
        { label => 'Incomplete exponent',   str => '1e',    expected => 0 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( is_valid_number( $case->{str} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
