#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Strong Password (The Weekly Challenge 287 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl aB2
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

This script determines the minimum number of steps required to make a given string a strong password based on the following criteria:

=over 4

=item * It has at least 6 characters.

=item * It contains at least one lowercase letter, one uppercase letter, and one digit.

=item * It does not contain three repeating characters in a row (e.g. "aaa" is not allowed).

=back

=head1 FUNCTIONS

=head2 strong_password_steps($s)

Calculates the minimum number of steps required to make the string a strong password.

=cut

signature_for strong_password_steps => (
    method     => 0,
    positional => [ Str ],
);

sub strong_password_steps ($s) {
    my $missing_types = 3;
    $missing_types-- if $s =~ /[a-z]/;
    $missing_types-- if $s =~ /[A-Z]/;
    $missing_types-- if $s =~ /\d/;

    my $repeats_to_fix = 0;
    my $i              = 2;
    my $n              = length($s);
    while ( $i < $n ) {
        if ( substr( $s, $i, 1 ) eq substr( $s, $i - 1, 1 ) && substr( $s, $i - 1, 1 ) eq substr( $s, $i - 2, 1 ) ) {
            my $repeat_len = 3;
            while ( $i + 1 < $n && substr( $s, $i + 1, 1 ) eq substr( $s, $i, 1 ) ) {
                $repeat_len++;
                $i++;
            }
            $repeats_to_fix += int( $repeat_len / 3 );
        }
        $i++;
    }

    my $total_steps;
    if ( $n >= 6 ) {
        $total_steps = ( $missing_types > $repeats_to_fix ) ? $missing_types : $repeats_to_fix;
    }
    else {
        my $insertions_needed = 6 - $n;
        my $sum               = $missing_types + $repeats_to_fix;
        $total_steps = ( $sum > $insertions_needed ) ? $sum : $insertions_needed;
    }
    return $total_steps;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = strong_password_steps( $args[0] );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', str => 'a',         expected => 5 },
        { label => 'Example 2', str => 'aB2',       expected => 3 },
        { label => 'Example 3', str => 'PaaSW0rd',  expected => 0 },
        { label => 'Example 4', str => 'Paaasw0rd', expected => 1 },
        { label => 'Example 5', str => 'aaaaa',     expected => 3 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( strong_password_steps( $case->{str} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
