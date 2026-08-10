#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    # Check the input only contains zeros and ones
    if ( $input_string !~ /^[01]+$/ ) {
        die "Invalid input provided\n";
    }

    # Record all valid substrings
    my %valid_substring = ();
    my $half_length     = int( length($input_string) / 2 );
    foreach my $l ( 1 .. $half_length ) {
        $valid_substring{ "0" x $l . "1" x $l } = 1;
        $valid_substring{ "1" x $l . "0" x $l } = 1;
    }

    # Find the substrings that are valid
    my @results = ();
    my $l       = length($input_string);
    foreach my $start ( 0 .. $l - 2 ) {
        for ( my $length = 2 ; $length <= $l - $start ; $length += 2 ) {
            my $substring = substr( $input_string, $start, $length );
            if ( exists $valid_substring{$substring} ) {
                push @results, $substring;
            }
        }
    }

    # Display the results
    say "(" . join( ", ", map { qq{"$_"} } @results ) . ")";
}

main(@ARGV);
