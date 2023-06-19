#!/usr/bin/perl
use strict;
use warnings;

sub pythagorean_triples {
    my $N     = shift;
    my $found = 0;
    for my $a ( 1 .. $N ) {
        for my $b ( $a .. $N ) {
            my $c = sqrt( $a**2 + $b**2 );
            if ( $c == int($c) ) {
                if ( $a == $N || $b == $N || $c == $N ) {
                    print "($a, $b, $c)\n";
                    $found = 1;
                }
            }
        }
    }
    print "-1\n" if not $found;
}

pythagorean_triples(5);
pythagorean_triples(13);
pythagorean_triples(1);
