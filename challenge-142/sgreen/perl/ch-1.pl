#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _get_divisors {
    my $number = shift;

    # Every number is divisible by 1
    my @divisors = (1);

    # One only has one divisor
    return @divisors if $number == 1;

    # Find other divisors
    foreach my $i ( 2 .. int( $number / 2 ) ) {
        if ( $number % $i == 0 ) {
            push @divisors, $i;
        }
    }

    # ... including the number itself
    push @divisors, $number;

    return @divisors;
}

sub main {
    my ( $m, $n ) = @_;

    die "The first must be a positive integer\n"
      if $m < 1;
    die "The second number must be between 1 and 9\n"
      if $n < 1 or $n > 9;

    # Get a list of divisors and find those that end with n.
    my @solution = grep { $_ % 10 == $n } _get_divisors($m);
    say scalar(@solution);
}

main(@ARGV);
