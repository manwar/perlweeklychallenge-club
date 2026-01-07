#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-2.pl - Perfect Totient Numbers

=head1 SYNOPSIS

  perl ch-2.pl

=head1 DESCRIPTION

Generate the first 20 perfect totient numbers.

A positive integer n is a perfect totient number if:

  n = phi(n) + phi(phi(n)) + phi(phi(phi(n))) + ... until 1

=cut

sub _totients_up_to ($limit) {
    my @phi = ( 0 .. $limit );
    for my $p ( 2 .. $limit ) {
        next if $phi[$p] != $p;    # not prime
        for ( my $k = $p ; $k <= $limit ; $k += $p ) {
            $phi[$k] -= int( $phi[$k] / $p );
        }
    }
    return \@phi;
}

sub perfect_totient_numbers ($count) {
    ($count) = compile(Int)->($count);
    die 'Expected count > 0' if $count <= 0;

    # The spec provides the first 20 values and the 20th is 5571.
    # Use that as an upper bound for an efficient totient sieve.
    my $limit = 5571;
    my $phi   = _totients_up_to($limit);

    my @out;
    for my $n ( 2 .. $limit ) {
        my $sum = 0;
        my $x   = $n;
        while ( $x > 1 ) {
            $x = $phi->[$x];
            $sum += $x;
        }
        push @out, $n if $sum == $n;
        last if @out == $count;
    }

    die "Unable to find $count perfect totient numbers up to $limit" if @out != $count;
    return \@out;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0\n" if @args;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $expected = [
        3, 9, 15, 27, 39, 81, 111, 183, 243, 255,
        327, 363, 471, 729, 2187, 2199, 3063, 4359, 4375, 5571
    ];

    Test::More::plan( tests => 1 );
    Test::More::is_deeply( perfect_totient_numbers(20), $expected, 'First 20 perfect totient numbers' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 perfect_totient_numbers($count)

Returns an arrayref with the first C<$count> perfect totient numbers.

=cut
