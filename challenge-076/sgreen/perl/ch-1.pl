#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub _is_prime {
    my $value = shift;
    my $sqrt  = int( sqrt($value) );

    for my $i ( 2 .. $sqrt ) {
        return 0 if $value % $i == 0;
    }

    return 1;
}

sub main {
    my $target = shift;

    # Sanity check
    die "Number must be a positive integer > 1\n"
      unless $target =~ /^\d+$/ and $target > 1;

    my @numbers = ();
    for ( my $number = $target ; $number >= 2 ; $number-- ) {
        if ( not _is_prime($number) ) {
            # We can't use this number if it isn't a prime
            next;
        }
        elsif ( $number == $target ) {
            # We've found the best solution!
            push @numbers, $target;
            $target -= $number;
            last;
        }
        elsif ( $number == $target - 1 ) {
            # Avoid using a prime if it is one less than the target. This
            #  prevents using 7 when working out the prime numbers that
            #  make up the sum of 8.
            next;
        }

        # We can use this number. We might want to use it again in case
        #  it is required. For example, 6 = 3 + 3.
        push @numbers, $number;
        $target -= $number;

        # We can reduce the number to the target as we know all primes
        #  between $target + 1 and $number won't match
        $number = $target if $number > $target;

        redo;
    }

    if ( $target != 0 ) {
        die "We have not found a solution!\n";
    }

    say 'Result is ', scalar(@numbers), ', made up of (',
      join( ',', @numbers ), ')';
}

main(@ARGV);
