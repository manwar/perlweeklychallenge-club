#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    my %digits = ();
    for my $char ( split //, $input_string ) {
        if ( $char =~ /[0-9]/ ) {
            $digits{$char} = 1;
        }
    }

    if ( scalar( keys(%digits) ) < 2 ) {
        say -1;
    }
    else {
        my @sorted_digits = sort { $a <=> $b } keys %digits;
        say $sorted_digits[-2];
    }
}

main(@ARGV);
