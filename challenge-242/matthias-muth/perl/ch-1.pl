#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 242 Task 1: Missing Members
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

use List::Util qw( uniq );

sub missing_members( $arr1, $arr2 ) {
    my %arr1_members = map { ( $_ => 1 ) } $arr1->@*;
    my %arr2_members = map { ( $_ => 1 ) } $arr2->@*;
    return (
	[ uniq grep ! $arr2_members{$_}, $arr1->@* ],
	[ uniq grep ! $arr1_members{$_}, $arr2->@* ],
    );
}

run_tests;
