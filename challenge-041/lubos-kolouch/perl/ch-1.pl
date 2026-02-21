#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Attractive Numbers

=head1 SYNOPSIS

  perl ch-1.pl          # runs the embedded tests
  perl ch-1.pl          # (same) lists attractive numbers 1..50 when tests pass

=head1 DESCRIPTION

Display attractive numbers between 1 and 50.

A number is I<attractive> if the number of its prime factors (counted with
multiplicity) is itself a prime number.

Example from the spec: 20 has prime factors 2,2,5 (count 3), and 3 is prime.

=cut

sub is_prime ($n) {
    return 0 if $n < 2;
    return 1 if $n == 2;
    return 0 if $n % 2 == 0;
    for ( my $d = 3 ; $d * $d <= $n ; $d += 2 ) {
        return 0 if $n % $d == 0;
    }
    return 1;
}

sub prime_factor_count ($n) {
    die "Expected positive integer\n" if $n !~ /^\d+$/ || $n < 1;

    my $count = 0;
    my $x     = $n;

    while ( $x % 2 == 0 ) { ++$count; $x /= 2 }
    for ( my $p = 3 ; $p * $p <= $x ; $p += 2 ) {
        while ( $x % $p == 0 ) { ++$count; $x /= $p }
    }
    ++$count if $x > 1;

    return $count;
}

sub is_attractive ($n) {
    return is_prime( prime_factor_count($n) );
}

sub attractive_numbers_1_to_50 () {
    return [ grep { is_attractive($_) } 1 .. 50 ];
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is( prime_factor_count(20), 3,  '20 has 3 prime factors' );
    Test::More::ok( is_attractive(20),          '20 is attractive' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if (@args) {
        die "Run without arguments to execute embedded tests and print results.\n";
    }

    _run_tests();
    say join ', ', attractive_numbers_1_to_50()->@*;
}

_run_cli(@ARGV);

