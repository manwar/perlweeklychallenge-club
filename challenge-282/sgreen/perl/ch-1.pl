#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($int) {
    my @value  = split //, $int;
    my $length = scalar(@value);

    foreach my $pos ( 0 .. $length - 3 ) {
        if (    $value[$pos] == $value[ $pos + 1 ]
            and $value[$pos] == $value[ $pos + 2 ]
            and ( $pos == 0 or $value[$pos] != $value[ $pos - 1 ] )
            and ( $pos + 3 == $length or $value[$pos] != $value[ $pos + 3 ] ) )
        {
            say $value[$pos] x 3;
            return;
        }
    }

    say '-1';
}

main( $ARGV[0] );