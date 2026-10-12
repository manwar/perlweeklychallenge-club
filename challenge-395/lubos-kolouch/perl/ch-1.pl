#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - Complex Number Multiplication (WWC 395 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl "1+1i" "1+1i"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given two complex numbers as strings.
Write a script to return the multiplication of the given complex numbers
using the formula: (a + bi) * (c + di) = (ac - bd) + (ad + bc)i.

Output format for negative imaginary parts is "X+(-Y)i", matching the task specification.

=cut

my $STRS_CHECK = compile( Str, Str );

sub _parse_complex ($s) {
    if ( $s =~ /\A\s*([+-]?\d+)\s*\+\s*(?:\(([-+]?\d+)\)|([-+]?\d+))\s*i\s*\z/ ) {
        my $real = $1;
        my $imag = defined $2 ? $2 : $3;
        return ( int($real), int($imag) );
    }
    die "Invalid complex number format: $s";
}

sub _format_complex ( $real, $imag ) {
    if ( $imag < 0 ) {
        return "$real+($imag)i";
    }
    return "$real+${imag}i";
}

sub multiply_complex ( $num1, $num2 ) {
    ( $num1, $num2 ) = $STRS_CHECK->( $num1, $num2 );

    my ( $a, $b ) = _parse_complex($num1);
    my ( $c, $d ) = _parse_complex($num2);

    my $real = $a * $c - $b * $d;
    my $imag = $a * $d + $b * $c;

    return _format_complex( $real, $imag );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 num1 num2\n" if @args != 2;
    my $out = multiply_complex( $args[0], $args[1] );
    say qq{Output: "$out"};
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', num1 => '1+1i',        num2 => '1+1i',     expected => '0+2i' },
        { label => 'Example 2', num1 => '1+(-1)i',     num2 => '1+(-1)i',  expected => '0+(-2)i' },
        { label => 'Example 3', num1 => '0+3i',        num2 => '0+4i',     expected => '-12+0i' },
        { label => 'Example 4', num1 => '3+4i',        num2 => '3+(-4)i',  expected => '25+0i' },
        { label => 'Example 5', num1 => '50+(-20)i',   num2 => '-10+30i',  expected => '100+1700i' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( multiply_complex( $case->{num1}, $case->{num2} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 multiply_complex($num1, $num2)

Multiplies two complex numbers given as formatted strings and returns the result string.

=cut
