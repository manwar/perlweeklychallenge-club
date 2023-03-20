#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'first_index';

sub main ( $first_list, $second_list ) {
    # Turn the words into a list
    my @first_list  = ( $first_list  =~ /(\w+)/g );
    my @second_list = ( $second_list =~ /(\w+)/g );

    # We set the index_sum to one more than the greatest possible solution
    my $index_sum = $#first_list + $#second_list + 3;
    my @solution  = ();

    # Loop through the first_list
    while ( my ( $i1, $w ) = each @first_list ) {
        # See if it appears in the second list
        my $i2 = first_index { $_ eq $w } @second_list;
        if ( $i2 != -1 ) {
            # The the index sum of this word
            my $i = $i1 + $i2;
            if ( $i < $index_sum ) {
                # It is better than the previous solution
                @solution  = ($w);
                $index_sum = $i;
            }
            elsif ( $i == $index_sum ) {
                # It is the same as the previous solution
                push @solution, $w;
            }
        }
    }

    # Print the results
    if ( $#solution != -1 ) {
        say '("', join( '", "', @solution ), '")';
    }
    else {
        say '()';
    }
}

main(@ARGV);