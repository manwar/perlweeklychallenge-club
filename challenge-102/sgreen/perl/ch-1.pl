#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $length = shift;

    # Sanity check
    die "You must specify a number\n" if not defined $length;
    die "The number is not a positive integer\n" unless $length =~ /^[1-9][0-9]*$/;

    # Build a hash table with all the possible squares
    my %squares = ();
    my $counter = 0;
    while ( $counter**2 < 2 * 10**$length ) {
        ++$counter;
        $squares{ $counter**2 } = $counter;
    }

    my @solutions = ();
    my $r         = 10**( $length - 1 );
    while ( $r < 10**$length ) {
        my $r1 = reverse($r);
        push @solutions, $r if ( $r >= $r1 and $squares{ $r - $r1 } and $squares{ $r + $r1 } );
        ++$r;
    }

    if ( scalar(@solutions) ) {
        say join ' ', @solutions;
    }
    else {
        say 'No solutions found';
    }
}

main(@ARGV);

