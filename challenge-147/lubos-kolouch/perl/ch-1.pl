#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Truncatable Prime

=head1 SYNOPSIS

  perl ch-1.pl        # runs the embedded tests
  perl ch-1.pl 20     # prints first 20 left-truncatable primes

=head1 DESCRIPTION

Generate the first N left-truncatable primes in base 10.

A left-truncatable prime contains no 0 and remains prime when the leading
left digit is successively removed.

=cut

sub is_prime ($n) {
    return 0 if $n < 2;
    return 1 if $n == 2 || $n == 3;
    return 0 if $n % 2 == 0;

    my $limit = int( sqrt($n) );
    for ( my $d = 3 ; $d <= $limit ; $d += 2 ) {
        return 0 if $n % $d == 0;
    }
    return 1;
}

sub is_left_truncatable_prime ($n) {
    my $s = "$n";
    return 0 if $s =~ /0/;

    while ( length $s ) {
        return 0 if !is_prime( 0 + $s );
        substr( $s, 0, 1, '' );
    }
    return 1;
}

sub left_truncatable_primes ($count) {
    my @out;
    my $n = 2;
    while ( @out < $count ) {
        push @out, $n if is_left_truncatable_prime($n);
        ++$n;
    }
    return @out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 3 );

    Test::More::ok( is_left_truncatable_prime(9137), 'Example: 9137 is left-truncatable prime' );

    my @p = left_truncatable_primes(20);
    Test::More::is( scalar @p, 20, 'Generates 20 numbers' );
    Test::More::ok( ( !grep { !is_left_truncatable_prime($_) } @p ), 'All generated numbers match definition' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 [N]\n" if @args != 1 || $args[0] !~ /^\d+$/;
    my $n = 0 + $args[0];
    die "Expected N >= 1\n" if $n < 1;
    say join ', ', left_truncatable_primes($n);
}

_run_cli(@ARGV);

