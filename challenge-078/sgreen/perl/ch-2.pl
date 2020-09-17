#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

sub main {
    my ( $array, $shift ) = @_;

    # Split the values into an array
    my @array   = ( $array =~ /(\d+(?:\.\d+)?)/gm );
    my @shift   = ( $shift =~ /(\d+)/gm );
    my @results = ();

    foreach my $offset (@shift) {
        if ( $offset > $#array ) {
            die "$offset is >= the size of the array\n";
        }

        if ( $offset == 0 ) {
            push @results, [@array];
        }
        else {
            push @results, [ @array[ $offset .. $#array, 0 .. $offset - 1 ] ];
        }
    }

    foreach my $result (@results) {
        say '[', join( ' ', @$result ), ']';
    }
}

main(@ARGV);
