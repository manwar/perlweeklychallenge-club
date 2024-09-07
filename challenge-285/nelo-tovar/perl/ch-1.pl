#!/usr/bin/env perl

# The Weekly Challenge 285 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
#
# Task 1 - No Connection
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ ["B","C"], ["D","B"], ["C","A"] ],
    [ ["A","Z"] ],
);

sub no_connection {
    my $routes = shift;
    my @departures = map {$_->[0]} @$routes;
    my @arrivals = map {$_->[1]} @$routes;

    foreach my $a (@arrivals) {
        my $temp = scalar grep { $_ eq $a } @departures;
        
        return $a if ( scalar $temp eq 0 ) 
    }

    return ''
}

for my $elements (@examples) {
    my $nc = no_connection $elements;

    say 'Input : @routes = ', dump(@$elements);
    say 'Output : ', $nc;
    say ' ';
}
