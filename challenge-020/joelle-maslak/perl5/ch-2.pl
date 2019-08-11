#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(max sum);
use integer;

MAIN: {
    my @factors;
    my @results;

    my $i = 2;
    while ( $i++ ) {
        my $sum = factorsum($i);
        $factors[$i] = $sum;

        if ( ( $sum > 1 ) && ( $sum < $i ) ) {
            if ( $i == $factors[$sum] ) {
                say "$sum $i";
                exit;
            }
        }
    }

    say sum @results;
}

sub factorsum($num) {
    my @f;
    my $sqrt = sqrt $num;

    push @f, 1;
    if ( $sqrt * $sqrt == $num ) { push @f, $sqrt; }

    for ( my $i = 2; $i < $sqrt; $i++ ) {
        if ( $num % $i != 0 ) { next; }
        push @f, $i, $num / $i;
    }

    return sum @f;
}

