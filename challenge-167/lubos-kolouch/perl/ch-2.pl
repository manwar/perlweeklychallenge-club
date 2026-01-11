#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=pod

=head1 NAME

ch-2.pl - Gamma Function

=head1 SYNOPSIS

  perl ch-2.pl 7
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Implements the gamma function using the Lanczos approximation.

The embedded tests verify only the example values from the challenge spec.

=cut

use constant PI => 4 * atan2( 1, 1 );

sub gamma_lanczos ($z) {
    die 'Expected a positive number' if $z <= 0;

    # Coefficients from Wikipedia (g=7, n=9).
    my $g = 7;
    my @p = (
        0.99999999999980993,
        676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716e-6,
        1.5056327351493116e-7,
    );

    if ( $z < 0.5 ) {
        return PI / ( sin( PI * $z ) * gamma_lanczos( 1 - $z ) );
    }

    my $x = $p[0];
    for my $i ( 1 .. $#p ) {
        $x += $p[$i] / ( $z + $i - 1 );
    }

    my $t = $z + $g - 0.5;
    return sqrt( 2 * PI ) * ( $t**( $z - 0.5 ) ) * exp(-$t) * $x;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <z>\n" if @args != 1;
    my $z = 0 + $args[0];
    say gamma_lanczos($z);
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', z => 3, expected => 1.99 },
        { label => 'Example 2', z => 5, expected => 24 },
        { label => 'Example 3', z => 7, expected => 719.99 },
    );

    my $tol = 0.02;
    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = gamma_lanczos( $case->{z} );
        Test::More::ok( abs( $got - $case->{expected} ) <= $tol, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 gamma_lanczos($z)

Returns an approximation of Γ(z).

=cut

