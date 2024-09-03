#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(noconnection([['B', 'C'], ['D', 'B'], ['C', 'A']]), 'A', 'example 1');
is(noconnection([['A', 'Z']]), 'Z', 'example 2');

sub noconnection($a) {
    my %os = map {$_->[0] => 1} @{$a};
    my %is = map {$_->[1] => 1} @{$a};
    foreach my $k (keys %os) {
      delete $is{$k};
    }
    return (keys %is)[0];
}
