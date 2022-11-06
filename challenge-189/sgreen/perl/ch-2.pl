#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(max sum);

sub get_degree (@nums) {
    # Return the highest frequency of a set of numbers
    my %count = ();
    foreach my $i (@nums) {
        $count{$i}++;
    }

    return max( values(%count) );
}

sub main (@nums) {
    # Calculate the degree
    my $degree = get_degree(@nums);

    # Store the best thing found so far
    my @solution = ();
    my $total    = undef;

    foreach my $start ( 0 .. $#nums - $degree + 1 ) {
        foreach my $end ( $start + $degree - 1 .. $#nums ) {

            my @value = @nums[ $start .. $end ];

            # Check if value has the same degree and is lower than the current
            #  value (or the current value is not)
            if ( get_degree(@value) == $degree
                and ( not defined $total or sum(@value) < $total ) )
            {

                # We have a new best solution
                @solution = @value;
                $total    = sum(@value);
            }
        }
    }

    # Display the result
    say join ', ', @solution;
}

main(@ARGV);