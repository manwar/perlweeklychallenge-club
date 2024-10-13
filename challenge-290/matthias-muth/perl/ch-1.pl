#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 290 Task 1: Double Exist
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw( any );

sub double_exist( @ints ) {
    my %existence = map { $_ => 1 } @ints;
    return any { $existence{ $_ * 2 } } @ints;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

ok double_exist( 6, 2, 3, 3 ),
    'Example 1: double_exist( 6, 2, 3, 3 ) is true';
ok ! double_exist( 3, 1, 4, 13 ),
    'Example 2: double_exist( 3, 1, 4, 13 ) is false';
ok double_exist( 2, 1, 4, 2 ),
    'Example 3: double_exist( 2, 1, 4, 2 ) is true';

done_testing;
