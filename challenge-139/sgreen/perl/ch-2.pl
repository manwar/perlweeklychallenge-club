#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_prime {
    my $number = shift;
    my $sqrt   = int( sqrt($number) );

    for my $i ( 2 .. $sqrt ) {
        return 0 if $number % $i == 0;
    }

    return 1;
}

sub _long_division {
    my $number = shift;
    my $digits = 0;

    my $r    = 10 % $number;
    my %seen = ( $r => 1 );

    while ( ++$digits ) {
        $r = ( 10 * $r ) % $number;
        last if $seen{$r}++;
    }

    return $digits;
}

sub main {
    my $count     = shift // 5;
    my $number    = 2;
    my @solutions = ();

    while ( ++$number ) {
        push @solutions, $number if _is_prime($number) and _long_division($number) == $number - 1;

        last if scalar(@solutions) == $count;
    }

    say join ', ', @solutions;
}

main(@ARGV);
