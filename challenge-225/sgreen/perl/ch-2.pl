#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@n) {
    # Calculate left and right lists
    my $l     = scalar(@n);
    my @left  = ( 0, map { sum( @n[ 0 .. $_ ] ) } ( 0 .. $l - 2 ) );
    my @right = ( map( { sum( @n[ $_ .. $l - 1 ] ) } ( 1 .. $l - 1 ) ), 0 );

    # Calculate the absolute difference between the list
    my @solution = map { abs( $left[$_] - $right[$_] ) } ( 0 .. $#n );
    say join ', ', @solution;
}

main(@ARGV);