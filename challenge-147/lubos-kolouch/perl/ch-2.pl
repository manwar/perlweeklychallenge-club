#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Pentagon Numbers

=head1 SYNOPSIS

  perl ch-2.pl         # runs the embedded tests
  perl ch-2.pl run     # prints the first qualifying pair

=head1 DESCRIPTION

Find the first pair of pentagonal numbers whose sum and difference are also
pentagonal numbers.

Pentagon numbers are defined as P(n) = n(3n - 1)/2.

=cut

sub pentagonal ($n) {
    return int( $n * ( 3 * $n - 1 ) / 2 );
}

sub is_pentagonal ($x) {
    return 0 if $x <= 0;

    my $d = 24 * $x + 1;
    my $s = int( sqrt($d) );
    return 0 if $s * $s != $d;
    return ( ( $s + 1 ) % 6 ) == 0;
}

sub first_pair () {
    my @p;

    for ( my $n = 1 ; ; ++$n ) {
        my $pn = pentagonal($n);
        push @p, $pn;

        for my $pj (@p[ 0 .. $#p - 1 ]) {
            my $sum  = $pn + $pj;
            my $diff = $pn - $pj;
            $diff = -$diff if $diff < 0;

            if ( is_pentagonal($sum) && is_pentagonal($diff) ) {
                return ( $pj, $pn );
            }
        }
    }
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @first10 = ( 1, 5, 12, 22, 35, 51, 70, 92, 117, 145 );

    Test::More::plan( tests => 1 + scalar(@first10) + 3 );

    Test::More::ok( !is_pentagonal(48), 'Example: 48 is not pentagonal' );

    for my $x (@first10) {
        Test::More::ok( is_pentagonal($x), "Pentagonal: $x" );
    }

    my ( $a, $b ) = first_pair();
    Test::More::ok( is_pentagonal($a) && is_pentagonal($b), 'Returned values are pentagonal' );
    Test::More::ok( is_pentagonal( $a + $b ),              'Sum is pentagonal' );
    Test::More::ok( is_pentagonal( abs( $a - $b ) ),       'Difference is pentagonal' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 run\n" if @args != 1 || $args[0] ne 'run';
    my ( $a, $b ) = first_pair();
    say "Pair of Pentagon Numbers: $a, $b";
}

_run_cli(@ARGV);

