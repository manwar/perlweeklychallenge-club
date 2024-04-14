#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@inputs) {
    my @source  = ( $inputs[0] =~ /(\d+)/g );
    my @indices = ( $inputs[1] =~ /(\d+)/g );
    if ( $#source != $#indices ) {
        die "Lists are of different length\n";
    }

    my @solution = ();
    foreach my $i ( 0 .. $#source ) {
        splice( @solution, $indices[$i], 0, $source[$i] );
    }

    say '(', join( ',', @solution ), ')';
}

main(@ARGV);