#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Smith Numbers

=head1 SYNOPSIS

  perl ch-2.pl        # runs the embedded tests
  perl ch-2.pl 10     # prints first 10 Smith numbers

=head1 DESCRIPTION

A Smith number is a composite number for which the sum of its digits equals the
sum of the digits of its prime factorization (counting multiplicity).

This script generates the first N Smith numbers in base 10.

=cut

sub digit_sum ($n) {
    my $s = 0;
    $s += $_ for split //, $n;
    return $s;
}

sub prime_factors ($n) {
    my @factors;
    my $x = $n;

    while ( $x % 2 == 0 ) {
        push @factors, 2;
        $x /= 2;
    }

    my $p = 3;
    while ( $p * $p <= $x ) {
        while ( $x % $p == 0 ) {
            push @factors, $p;
            $x /= $p;
        }
        $p += 2;
    }

    push @factors, $x if $x > 1;
    return @factors;
}

sub is_composite ($n) {
    return 0 if $n < 4;            # 0,1,2,3 are not composite
    return 1 if $n % 2 == 0;
    for ( my $d = 3 ; $d * $d <= $n ; $d += 2 ) {
        return 1 if $n % $d == 0;
    }
    return 0;
}

sub is_smith ($n) {
    return 0 if !is_composite($n);

    my $sum_digits = digit_sum($n);
    my @pf         = prime_factors($n);
    my $sum_pf     = 0;
    $sum_pf += digit_sum($_) for @pf;

    return $sum_digits == $sum_pf ? 1 : 0;
}

sub first_smith_numbers ($count) {
    die 'Expected positive integer' if $count !~ /^\d+$/ || $count < 1;

    my @out;
    my $n = 4;
    while ( @out < $count ) {
        push @out, $n if is_smith($n);
        ++$n;
    }
    return @out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::plan( tests => 5 );

    # Derived from the definition: 4 is Smith (4 => 2*2; 4 -> 4, 2+2 -> 4)
    Test::More::ok( is_smith(4),  '4 is Smith' );
    Test::More::ok( !is_smith(10), '10 is not Smith' );

    my @s = first_smith_numbers(10);
    Test::More::is( scalar @s, 10, 'Generated 10 numbers' );
    Test::More::ok( ( !grep { !is_smith($_) } @s ), 'All generated numbers are Smith' );
    Test::More::ok( ( !grep { !is_composite($_) } @s ), 'All generated numbers are composite' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die "Usage: perl $0 <count>\n" if @args != 1;
    my $count = $args[0];
    say join ', ', first_smith_numbers($count);
}

_run_cli(@ARGV);

