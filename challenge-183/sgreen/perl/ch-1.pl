#!/usr/bin/env perl

use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

use JSON;

sub same_array ( $c, $d ) {
    # Determine if they are the same array

    # They aren't if they are different lengths
    return if $#$c != $#$d;
    for my $x ( 0 .. $#$c ) {
        # Or if the value is different
        return if $c->[$x] ne $d->[$x];
    }

    # They are the same!
    return 1;
}

sub main ($y) {
    my $array = decode_json($y);

    my @solution = ();
  I: foreach my $i ( 0 .. $#$array ) {

        # See if we have found this list before
        my $is_unique = 1;
        foreach my $j ( 0 .. $i - 1 ) {
            if ( same_array( $array->[$i], $array->[$j] ) ) {
                next I;
            }
        }

        # We haven't. Add it to the solutions
        push @solution, $array->[$i];
    }

    say '(', join( ', ', map( "[" . join( ', ', @$_ ) . ']', @solution ) ), ')';
}

main( $ARGV[0] );