#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    # Get the list as specified
    my @l              = @_;
    my @reordered_list = ();

    my $is_odd = @l % 2;
    my $x      = int( @l / 2 );

    # Get the Li and L-i values from the array
    for my $i ( 1 .. $x ) {
        push @reordered_list, $l[ $i - 1 ], $l[ -$i ];
    }

    # If the list is odd, get the middle value
    push @reordered_list, $l[$x] if $is_odd;

    # Output the list
    say join( ' ', @reordered_list );
}

main(@ARGV);
