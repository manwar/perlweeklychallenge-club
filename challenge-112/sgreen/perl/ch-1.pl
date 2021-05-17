#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $path   = shift // die "You must specify a path\n";
    my @parts  = split m^/^, $path;
    my @cparts = ();

    foreach my $part (@parts) {
        if ( $part eq '..' ) {
            # Go up one directory (noop if top directory)
            pop @cparts;
        }
        elsif ( $part ne '' ) {
            push @cparts, $part;
        }
    }

    say join '/', '', @cparts;
}

main(@ARGV);
