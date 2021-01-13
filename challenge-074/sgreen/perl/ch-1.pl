#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub main (@) {
    my @list = @_;

    # Count the number of times each values appear
    my %count = ();
    foreach my $item (@list) {
        $count{$item}++;
    }

    # Go through the values and see if any appear more than half the times
    while ( my ( $item, $count ) = each %count ) {
        if ( $count > scalar(@list) / 2 ) {
            say $item;
            return;
        }
    }

    # Nothing found, so return -1
    say -1;
}

main(@ARGV);
