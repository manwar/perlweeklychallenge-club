#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _find_numbers {
    my ( $remainder, $numbers, $all_numbers ) = @_;

    # Find out what digits remain (must be <= remainder)
    my @can_use = grep { $_ <= $remainder } @$all_numbers;

    foreach my $number (@can_use) {
        if ( $remainder == $number ) {
            # We have a solution, return that
            return [ @$numbers, $number ];
        }

        # Recurse this function
        my $solution = _find_numbers( $remainder - $number, [ @$numbers, $number ], $all_numbers );
        if ($solution) {
            return $solution;
        }
    }

    # There is no solution.
    return;
}

sub main {
    my ( $target, $digit ) = @_;

    # Sanity check
    die "The first value must be a positive integer\n" unless $target =~ /^[1-9][0-9]*$/;
    die "The second value must be a single digit\n"    unless $digit =~ /^[1-9]$/;

    # Two short circuits
    if ( index( $target, $digit ) != -1 ) {
        say "Output: 1 ($target contains $digit)";
        return;
    }
    elsif ( $target % $digit == 0 ) {
        my $n = $target / $digit;
        say "Output: 1 ($digit × $n)";
        return;
    }

    # Generate a list of all numbers that contain the digit
    my @numbers = reverse grep { index( $_, $digit ) != -1 } 1 .. $target - 1;

    # Find out if there is a solution with these numbers
    my $solution = _find_numbers( $target, [], \@numbers );
    if ($solution) {
        say 'Output: 1 (', join( ' + ', @$solution ), ')';
    }
    else {
        say 'Output: 0';
    }
}

main(@ARGV);
