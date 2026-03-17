#!/usr/bin/env perl

# Perl Weekly Challenge 285 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/

use Modern::Perl;

my @routes = map {[split ' ', $_]} split /,/, "@ARGV";
say join ", ", endpoints(@routes);

sub endpoints {
    my(@routes) = @_;
    my %endpoints;
    for (@routes) {
        my($a, $b) = @$_;
        $endpoints{$b}=1;
    }
    for (@routes) {
        my($a, $b) = @$_;
        delete $endpoints{$a};
    }
    return sort keys %endpoints;
}
