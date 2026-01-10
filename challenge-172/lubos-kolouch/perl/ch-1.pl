#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Type::Params    qw(compile_named);
use Types::Standard qw(Int);

=pod

=head1 NAME

ch-1.pl - Prime Partition

=head1 SYNOPSIS

  perl ch-1.pl 18 2
  perl ch-1.pl 19 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given positive integers $m and $n, find and print one partition of $m into
exactly $n distinct primes (if possible). Primes are printed in ascending order.

=cut

sub is_prime ($x) {
    return 0 if $x < 2;
    return 1 if $x == 2;
    return 0 if $x % 2 == 0;
    for (my $i = 3; $i * $i <= $x; $i += 2) {
        return 0 if $x % $i == 0;
    }
    return 1;
}

sub find_prime_partition ($remaining, $parts_left, $min_prime = 2) {
    if ($parts_left == 0) {
        return $remaining == 0 ? [] : undef;
    }

    my $inc = ($min_prime == 2 ? 1 : 2);
    my $p_start = $min_prime;
    if ($min_prime > 2 && $min_prime % 2 == 0) {
        $p_start += 1;
    }

    for (my $p = $p_start; $p <= $remaining - ($parts_left - 1) * 2; $p += $inc) {
        next unless is_prime($p);
        my $rest = find_prime_partition($remaining - $p, $parts_left - 1, $p + 1);
        return [ $p, @$rest ] if defined $rest;
    }
    return undef;
}

sub prime_partition ($m, $n) {
    my $check = compile_named( m => Int, n => Int );
    my $arg = $check->( m => $m, n => $n );
    my $mm = $arg->{m};
    my $nn = $arg->{n};
    die 'Expected positive integers' if $mm <= 0 || $nn <= 0;
    my $parts = find_prime_partition($mm, $nn);
    defined $parts or die "No prime partition found for $mm with $nn parts\n";
    return join ', ', @$parts;
}

sub _run_cli (@args) {
    if (!@args) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <m> <n>\n" if @args != 2;
    my ($m, $n) = map { 0 + $_ } @args;
    my $out = prime_partition($m, $n);
    say "Input:  \$m = $m, \$n = $n";
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', m => 18, n => 2, expected => qr/^(5, 13|7, 11)$/ },
        { label => 'Example 2', m => 19, n => 3, expected => qr/^3, 5, 11$/ },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = eval { prime_partition($case->{m}, $case->{n}) };
        Test::More::like( $got // '', $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 prime_partition($m, $n)

Returns a comma-separated string of one valid prime partition in ascending order.

=cut
