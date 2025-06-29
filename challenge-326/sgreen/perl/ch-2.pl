#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my @result = ();
    for ( my $i = 0 ; $i <= $#ints ; $i += 2 ) {
        my $count = $ints[$i];
        my $value = $ints[ $i + 1 ];
        foreach my $j ( 1 .. $count ) {
            push @result, $value;
        }
    }

    say "(" . join( ", ", @result ) . ")";
}

main(@ARGV);
