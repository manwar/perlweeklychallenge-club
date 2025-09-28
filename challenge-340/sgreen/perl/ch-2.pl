#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Extract numbers from the input string
    my @number_array = grep { /^\d+$/ } split /\s+/, $input_string;

    if ( $#number_array == -1 ) {
        die "No numbers found in the input string.\n";
    }

    # Check if the numbers are in ascending order
    foreach my $i ( 1 .. $#number_array ) {
        if ( $number_array[ $i - 1 ] >= $number_array[$i] ) {
            say "false";
            return;
        }
    }
    say "true";
}

main(@ARGV);
