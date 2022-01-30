#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say state);
use List::Util qw(any sum);

sub is_sum_fib {
    my $n = shift;
    state @fibs = ( 0, 1 );

    # Make sure we have all fibonacci numbers <= n
    while ( $fibs[-1] < $n ) {
        push @fibs, $fibs[-2] + $fibs[-1];
    }

    return any { $n == $_ } @fibs;
}

sub get_sum {
    return sum( split //, shift );
}

sub main {
    my $n         = shift;
    my $value     = 0;
    my @solutions = ();

    # Keep going until we have n solutions.
    while ( @solutions < $n ) {
        # If the sum of this number is a fibannoci number, add it
        if ( is_sum_fib( get_sum($value) ) ) {
            push @solutions, $value;
        }

        $value++;
    }

    say join ', ', @solutions;
}

main(@ARGV);