#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $B, $S ) = @_;

    # Sanity check
    die "You must enter a binary string\n"                        unless $B;
    die "You must enter an integer\n"                             unless $S;
    die "The binary string can only contain ones and zeros\n"     unless $B =~ /^[01]+$/;
    die "The second value doesn't look like a postive integer!\n" unless $S =~ /^[1-9][0-9]*$/;

    # Expand the binary string if necessary, and then split it
    while ( length($B) % $S ) { $B = "0$B" }
    my @chunks = unpack( "(A$S)*", $B );

    # Find the most used character at each bit
    my $most_used = '';
    foreach my $i ( 0 .. $S - 1 ) {
        my $is_set = scalar( grep { substr( $_, $i, 1 ) } @chunks );
        $most_used .= $is_set > scalar( @chunks / 2 ) ? '1' : '0';
    }

    # Calculate the number of flips required
    my $flips = 0;
    foreach my $chunk (@chunks) {
        foreach my $i ( 0 .. $S - 1 ) {
            ++$flips if substr( $chunk, $i, 1 ) ne substr( $most_used, $i, 1 );
        }
    }

    say $flips;

}

main(@ARGV);
