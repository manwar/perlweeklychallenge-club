#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 273 Task 2: B After A
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub b_after_a( $str ) {
    return $str =~ /^ [^b]* b [^a]* $/x;
}

use Test2::V0 qw( -no_srand );
ok b_after_a( "aabb" ),
    'Example 1: b_after_a( "aabb" ) is true';
ok ! b_after_a( "abab" ),
    'Example 2: b_after_a( "abab" ) is false';
ok ! b_after_a( "aaa" ),
    'Example 3: b_after_a( "aaa" ) is false';
ok b_after_a( "bbb" ),
    'Example 4: b_after_a( "bbb" ) is true';
done_testing;
