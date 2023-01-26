#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@n) {
    # Turn the array into a hash
    my %n = map { $_, 1 } @n;

    # Find numbers between 0 and the length of n that don't appear in the input
    my @missing = grep { !exists( $n{$_} ) } ( 0 .. $#n + 1 );

    say join ', ', @missing;
}

main(@ARGV);