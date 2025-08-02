#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 317 Task 2: Friendly Strings
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( zip );

sub friendly_strings( $str1, $str2 ) {
    my @unequals =
        grep $_->[0] ne $_->[1],
            zip [ split "", $str1 ], [ split "", $str2 ];
    return @unequals == 2 && "$unequals[0]->@[0,1]" eq "$unequals[1]->@[1,0]";
}

use Test2::V0 qw( -no_srand );

is friendly_strings( "desc", "dsec" ), T,
    'Example 1: friendly_strings( "desc", "dsec" ) is true';
is friendly_strings( "fuck", "fcuk" ), T,
    'Example 2: friendly_strings( "fuck", "fcuk" ) is true';
is friendly_strings( "poo", "eop" ), F,
    'Example 3: friendly_strings( "poo", "eop" ) is false';
is friendly_strings( "stripe", "sprite" ), T,
    'Example 4: friendly_strings( "stripe", "sprite" ) is true';

done_testing;
