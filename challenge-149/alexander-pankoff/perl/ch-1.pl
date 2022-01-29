#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #1 › Fibonacci Digit Sum
# Submitted by: Roger Bell_West
#
# Given an input $N, generate the first $N numbers for which the sum of their digits is a Fibonacci number.
# Example
#
# f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]

use List::Util qw(sum0 first);

run() unless caller();

sub run() {
    my ($N) = @ARGV;

    if ( !$N || $N !~ m/^\d+$/ || $N < 1 ) {
        die <<EOF;
  Usage:

    $0 N

  Options:

    N - a positive integer
EOF
    }

    my @numbers = fibonacci_digit_sum($N);

    say "f($N) = [" . join( ', ', @numbers ) . ']';

}

sub fibonacci_digit_sum($n) {
    my @found;
    for ( my $i = 0 ; @found < $n ; $i++ ) {
        push @found, $i if is_fib( digit_sum($i) );
    }
    return @found;

}

sub is_fib($x) {
    state $fibs = {
        0 => 1,
        1 => 1,

    };
    state $cur  = 1;
    state $prev = 0;

    while ( $x > $cur ) {
        my $next = next_fib( $cur, $prev );
        $prev = $cur;
        $cur  = $next;

        $fibs->{$next} = 1;
    }

    return $fibs->{$x};
}

sub digit_sum($x) {
    my $sum = sum0 split( '', $x );

    return $sum;
}

sub next_fib ( $prev, $cur ) {
    my $next = $cur + $prev;

    return $next;
}
