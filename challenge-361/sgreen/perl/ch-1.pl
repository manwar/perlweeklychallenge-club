#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub generate_fibonacci($number) {
    # Seed the sequence
    my @seq = ( 0, 1 );

    # Add to the sequence until we exceed the number
    while ( $seq[-1] <= $number ) {
        push @seq, $seq[-2] + $seq[-1];
    }

    # Remove largest number which will be greater than the target
    pop(@seq);
    return @seq;
}

sub main ($number) {
    if ( $number < 1 ) {
        # Check we have a positive integer
        die "The number must be a positive integer\n";
    }

    # Generate a list of fibonacci numbers <= number
    my @seq = generate_fibonacci($number);

    my $remaining = $number;
    my @result    = ();

    while (@seq) {
        # Remove the highest remaining value from the sequence
        my $value = pop(@seq);

        # If it is > what is remaining, we skip it
        if ( $value <= $remaining ) {
            # Reduce the remaining value and add to the result list
            $remaining -= $value;
            push @result, $value;

            if ( $remaining == 0 ) {
                # The target has been reached
                say join( ",", @result );
                return;
            }

            # Remove the next value from the sequence, as we cannot use
            #  consecutive numbers
            pop(@seq);
        }
    }

    # We should never reach here
    say -1;
}

main(@ARGV);
