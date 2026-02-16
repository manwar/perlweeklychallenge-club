#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-1.pl - Zeckendorf Representation

=head1 SYNOPSIS

  perl ch-1.pl         # runs the embedded tests
  perl ch-1.pl 20      # prints "13,5,2"

=head1 DESCRIPTION

Given a positive integer (<= 100), return its Zeckendorf representation:
every positive integer can be represented uniquely as the sum of
non-consecutive Fibonacci numbers.

This uses the greedy algorithm over Fibonacci numbers starting with 1, 2
(i.e. 1, 2, 3, 5, 8, ...), matching the examples.

=cut

sub zeckendorf ($n) {
    die "Expected positive integer <= 100\n" if $n !~ /^\d+$/ || $n < 1 || $n > 100;

    my @fibs = ( 1, 2 );
    while ( $fibs[-1] + $fibs[-2] <= $n ) {
        push @fibs, $fibs[-1] + $fibs[-2];
    }

    my @parts;
    my $i = $#fibs;
    my $remaining = $n;
    while ( $remaining > 0 ) {
        if ( $fibs[$i] <= $remaining ) {
            push @parts, $fibs[$i];
            $remaining -= $fibs[$i];
            $i -= 2;
        }
        else {
            --$i;
        }
    }

    return \@parts;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is_deeply( zeckendorf(4),   [ 3, 1 ],       'Example 1' );
    Test::More::is_deeply( zeckendorf(12),  [ 8, 3, 1 ],    'Example 2' );
    Test::More::is_deeply( zeckendorf(20),  [ 13, 5, 2 ],   'Example 3' );
    Test::More::is_deeply( zeckendorf(96),  [ 89, 5, 2 ],   'Example 4' );
    Test::More::is_deeply( zeckendorf(100), [ 89, 8, 3 ],   'Example 5' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <int>\n" if @args != 1;
    say join ',', zeckendorf( $args[0] )->@*;
}

_run_cli(@ARGV);

