#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Check we only have numbers
    if ( $input_string !~ /^\d+$/ ) {
        die "String should only contain numbers\n";
    }

    # Calculate the frequency of all digits
    my %freq = ();
    foreach my $digit ( split //, $input_string ) {
        $freq{$digit}++;
    }

    my $largest_number = 0;
    while ( my ( $digit, $count ) = each %freq ) {
        # Compute the number of the concatenated digits
        my $number = $digit x $count;

        # Update largest_number if required.
        if ( $number > $largest_number ) {
            $largest_number = $number;
        }
    }

    say $largest_number;
}

main(@ARGV);
