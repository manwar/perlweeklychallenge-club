#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@arg) {
    # Extract anything that looks like an integer
    my @n = ( join( ' ', @arg ) =~ /(-?[0-9]+)/g );

    # Remove the last two numbers
    my ($r, $c) = splice(@n, -2);

    # Check there there is a viable solution
    if ( scalar(@n) != $c * $r ) {
        say 0;
        return;
    }

    # Print the result
    for ( my $i = 0 ; $i <= $#n ; $i += $c ) {
        say '[ ', join( ' ', @n[ $i .. $i + $c - 1 ] ), ' ]';
    }
}

main(@ARGV);