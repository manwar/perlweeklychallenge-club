#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@array) {
    # Take off the last value, and sort the remaining numbers
    my $n = pop(@array);
    @array = sort { $a <=> $b } @array;
    my @solution = ();

    while ( scalar @array ) {
        # Get the smallest number, and create a set with expected numbers
        my @expected    = ( $array[0] .. $array[0] + $n - 1 );
        my %not_matched = map { $_ => 1 } @expected;

        # Create an new array less the first instance of each number in the hash
        my @new_array = ();
        foreach my $num (@array) {
            if ( exists $not_matched{$num} ) {
                delete $not_matched{$num};
            }
            else {
                push @new_array, $num;
            }
        }

        if ( scalar keys(%not_matched) ) {
            # We don't have the expected numbers
            say -1;
            return;
        }

        # We have a solution
        push @solution, '(' . join( ',', @expected ) . ')';
        @array = @new_array;
    }

    # Print the solution
    say join( ', ', @solution );
}

main(@ARGV);