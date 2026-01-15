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

ch-2.pl - Largest Square

=head1 SYNOPSIS

  perl ch-2.pl 10
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a base, find the largest perfect square that, when written in that base,
uses no repeated digits. For base > 10, digits are represented with A..Z.

=cut

my $INT_CHECK = compile(Int);

my @DIGITS = ( '0' .. '9', 'A' .. 'Z' );

sub _to_base ($n, $base) {
    return '0' if $n == 0;
    my @out;
    my $x = $n;
    while ( $x > 0 ) {
        my $d = $x % $base;
        push @out, $DIGITS[$d];
        $x = int( $x / $base );
    }
    return join '', reverse @out;
}

sub _digits_unique ($n, $base) {
    my @seen = (0) x $base;
    my $x = $n;
    while ( $x > 0 ) {
        my $d = $x % $base;
        return 0 if ++$seen[$d] > 1;
        $x = int( $x / $base );
    }
    return 1;
}

sub largest_square ($base) {
    ($base) = $INT_CHECK->($base);
    die 'Expected base between 2 and 36' if $base < 2 || $base > 36;

    my $max = 0;
    for my $d ( reverse 0 .. $base - 1 ) {
        $max = $max * $base + $d;
    }

    my $t = int( sqrt($max) );
    while ( $t > 0 ) {
        my $sq = $t * $t;
        return _to_base( $sq, $base ) if _digits_unique( $sq, $base );
        --$t;
    }
    return '0';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <base>\n" if @args != 1;
    my $base = 0 + $args[0];
    say largest_square($base);
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', base => 2,  expected => '1' },
        { label => 'Example 2', base => 4,  expected => '3201' },
        { label => 'Example 3', base => 10, expected => '9814072356' },
        { label => 'Example 4', base => 12, expected => 'B8750A649321' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( largest_square( $case->{base} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 largest_square($base)

Returns the largest square (as a string) in the given base with unique digits.

=cut

