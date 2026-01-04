#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Int Str);

=pod

=head1 NAME

ch-1.pl - Quater-imaginary Base

=head1 SYNOPSIS

  perl ch-1.pl 4
  perl ch-1.pl 10300
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Convert a base-10 integer to quater-imaginary base (base 2i) and vice-versa.

For real integers, the quater-imaginary representation has 0 in every odd
position and can be obtained by converting the number to base -4 and
inserting 0s between digits.

=cut

my $INT_CHECK = compile(Int);
my $STR_CHECK = compile(Str);

sub _to_base_neg4 ($n) {
    my @digits;
    while ( $n != 0 ) {
        my $r = $n % 4;
        $r += 4 if $r < 0;
        push @digits, $r;
        $n = ( $n - $r ) / -4;
    }
    return [0] if !@digits;
    return [ reverse @digits ];
}

sub to_quater_imaginary ($n) {
    ($n) = $INT_CHECK->($n);
    my $d = _to_base_neg4($n);
    return join '0', map { "$_" } @$d;
}

sub from_quater_imaginary ($s) {
    ($s) = $STR_CHECK->($s);
    die 'Expected digits 0..3 only' if $s !~ /\A[0-3]+\z/;

    my ( $re, $im ) = ( 0, 0 );
    for my $ch ( split //, $s ) {
        my $digit = 0 + $ch;
        ( $re, $im ) = ( -2 * $im, 2 * $re );
        $re += $digit;
    }
    die 'Not a real number' if $im != 0;
    return $re;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <integer|quater-imaginary>\n" if @args != 1;
    my $arg = $args[0];
    if ( $arg =~ /\A-?\d+\z/ ) {
        my $n = 0 + $arg;
        my $out = to_quater_imaginary($n);
        say "Input:  $n";
        say "Output: $out";
        return;
    }
    my $out = from_quater_imaginary($arg);
    say "Input:  $arg";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;
    Test::More::plan( tests => 2 );
    Test::More::is( to_quater_imaginary(4), '10300', 'Example: 4 -> 10300' );
    Test::More::is( from_quater_imaginary('10300'), 4, 'Example: 10300 -> 4' );
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 to_quater_imaginary($n)

Convert base-10 integer to base 2i representation.

=head2 from_quater_imaginary($s)

Convert base 2i representation to base-10 integer (real results only).

=cut

