#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 332 Task 2: Odd Letters
#
#       Perl solution by Matthias Muth.
#

use v5.42;
use feature 'keyword_all';
no warnings 'experimental::keyword_all';

sub odd_letters( $str ) {
    my %is_odd;
    $is_odd{$_} ^= 1
        for split //, $str;
    return all { $_ } values %is_odd;
}

use Test2::V0 qw( -no_srand );

is odd_letters( "weekly" ), F,
    'Example 1: odd_letters( "weekly" ) is false';
is odd_letters( "perl" ), T,
    'Example 2: odd_letters( "perl" ) is true';
is odd_letters( "challenge" ), F,
    'Example 3: odd_letters( "challenge" ) is false';

done_testing;
