#!/usr/bin/env perl

# You are given a positive integer (<= 100).

# Write a script to return Zeckendorf Representation of the given integer.

#     Every positive integer can be uniquely represented as sum of
#     non-consecutive Fibonacci numbers.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub fib {
    state $memo = { 1 => 1, 2 => 1 };
    return $memo->{ $_[0] } //= fib( $_[0] - 1 ) + fib( $_[0] - 2 );
}

sub zeckendorf_representation {
    my $int = shift;

    my @results;
    print 'Input: $int = ' . $int . "\n";

    my @fibs;
    FIBS:
    for my $f ( 1 .. 11 ) {
        my $fib = fib($f);
        push @fibs, $fib;
        last FIBS if ( $fib > 100 );
    }

    FIB:
    while ( scalar @fibs ) {
        my $val = pop @fibs;
        next FIB if ( $int < $val );
        $int -= $val;
        push @results, $val;
        pop @fibs;
    }

    say 'Output: ' . join( ', ', @results );
    return [@results];
}

my @examples = (
                 { in => 4,   out => [ 3, 1 ], name => 'example 1' },
                 { in => 12,  out => [ 8,  3, 1 ], name => 'example 2' },
                 { in => 20,  out => [ 13, 5, 2 ], name => 'example 3' },
                 { in => 96,  out => [ 89, 5, 2 ], name => 'example 4' },
                 { in => 100, out => [ 89, 8, 3 ], name => 'example 5' },
               );

is( zeckendorf_representation( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

