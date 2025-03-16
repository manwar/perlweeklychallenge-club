#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($str) {
    # Make sure we have valid input
    if ( $str !~ /^(?:[RGB][0-9])+$/ ) {
        die "Invalid input\n";
    }

    # Put balls in boxes
    my %boxes = ();
    foreach my $c ( $str =~ /([RGB][0-9])/g ) {
        $boxes{ substr( $c, 1, 1 ) }{ substr( $c, 0, 1 ) } = 1;
    }

    # Count the number of boxes that have three balls
    my $count = grep { scalar(keys(%$_)) == 3 } values(%boxes);
    say $count;
}

main( $ARGV[0] );