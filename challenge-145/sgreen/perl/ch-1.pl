#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'sum';

sub main {
    my @first_nums  = ( shift =~ /(-?\d+(?:\.\d+)?)/gm );
    my @second_nums = ( shift =~ /(-?\d+(?:\.\d+)?)/gm );

    if ( @first_nums != @second_nums ) {
        die "Arrays are of different lengths\n";
    }

    my @dots = ();
    my @sums = ();

    foreach my $i ( 0 .. $#first_nums ) {
        push @dots, "($first_nums[$i] × $second_nums[$i])";
        push @sums, $first_nums[$i] * $second_nums[$i];
    }

    say join( ' + ', @dots ), ' => ', join( ' + ', @sums ), ' => ', sum(@sums);
}

main(@ARGV);
