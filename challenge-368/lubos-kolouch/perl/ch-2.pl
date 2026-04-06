#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;

=head1 NAME

BigAndLittleOmega - Count prime factors

=head1 SYNOPSIS

  perl ch-2.pl 971088 0
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a positive integer and a mode flag:
- mode 0 (little omega): count of ALL DISTINCT prime factors
- mode 1 (big omega):   count of ALL prime factors INCLUDING duplicates

=cut

sub factorize {
    my ($n) = @_;
    my @factors;

    for my $d (2 .. $n) {
        last if $d * $d > $n;
        while ($n % $d == 0) {
            push @factors, $d;
            $n /= $d;
        }
    }
    push @factors, $n if $n > 1;
    return @factors;
}

sub omega {
    my ($number, $mode) = @_;
    die "Expected positive integer\n" unless defined $number && $number > 0;
    die "Expected mode 0 or 1\n" unless defined $mode && ($mode == 0 || $mode == 1);

    my @factors = factorize($number);

    if ($mode == 0) {
        # little omega: distinct prime factors
        my %seen;
        $seen{$_}++ for @factors;
        return scalar keys %seen;
    } else {
        # big omega: all prime factors including duplicates
        return scalar @factors;
    }
}

sub _run_cli {
    my (@args) = @_;
    if (!@args) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <number> <mode>\n" if @args != 2;
    my ($number, $mode) = map { 0 + $_ } @args;
    my $result = omega($number, $mode);
    say "Input:  \$number = $number, \$mode = $mode";
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', number => 100061,  mode => 0, expected => 3 },
        { label => 'Example 2', number => 971088,  mode => 0, expected => 3 },
        { label => 'Example 3', number => 63640,   mode => 1, expected => 6 },
        { label => 'Example 4', number => 988841,  mode => 1, expected => 2 },
        { label => 'Example 5', number => 211529,  mode => 0, expected => 2 },
    );

    Test::More::plan(tests => scalar @cases);
    for my $case (@cases) {
        my $got = omega($case->{number}, $case->{mode});
        Test::More::is($got, $case->{expected}, "$case->{label}: $got");
    }
}

_run_cli(@ARGV);
