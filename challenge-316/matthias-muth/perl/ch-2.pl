#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 316 Task 2: Subsequence
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub subsequence( $str1, $str2 ) {
    my $re = join ".*?", split "", $str1;
    return $str2 =~ /$re/;
}

use Test2::V0 qw( -no_srand );

is subsequence( "uvw", "bcudvew" ), T,
    'Example 1: subsequence( "uvw", "bcudvew" ) is true';
is subsequence( "aec", "abcde" ), F,
    'Example 2: subsequence( "aec", "abcde" ) is false';
is subsequence( "sip", "javascript" ), T,
    'Example 3: subsequence( "sip", "javascript" ) is true';

done_testing;
