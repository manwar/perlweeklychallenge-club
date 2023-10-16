#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 238 Task 2: Persistence Sort
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

use List::Util qw( product );

sub steps_needed( $n ) {
    my $n_steps = 0;
    while ( $n > 9 ) {
	++$n_steps;
	$n = product( split "", $n );
    }
    return $n_steps;
}

sub persistence_sort( @int ) {
    my %steps = map { ( $_, scalar steps_needed( $_ ) ) } @int;
    return sort { $steps{$a} <=> $steps{$b} || $a <=> $b } @int;
}

run_tests;
