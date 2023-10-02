#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 229 Task 1: Lexicographic Order
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

sub lexicographic_order( @str ) {
    my $a_to_z = join "", map( "$_*", "a".."z" );
    my $z_to_a = join "", map( "$_*", reverse "a".."z" );
    return scalar grep { ! /^$a_to_z$/i && ! /^$z_to_a$/i } @str;
}

run_tests;
