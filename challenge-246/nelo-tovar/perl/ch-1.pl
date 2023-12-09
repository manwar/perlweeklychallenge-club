#!/usr/bin/env perl

# The Weekly Challenge 246 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
#
# Task 1 - 6 out of 49 
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);


sub get_6_of_49 {
    my $low = 6;
    my $up = 49;
    my $amount = 6;
    my @randoms = ();

    while ( @randoms != $amount) {
        my $random_number = int( rand($up - $low + 1)) + $low;

        push @randoms, $random_number if ( ! grep( { $_ == $random_number } @randoms ) );
    }

    @randoms = sort {$a <=> $b} @randoms;
    
    return \@randoms;
}

my $numbers = get_6_of_49;
say join("\n", @$numbers) 
