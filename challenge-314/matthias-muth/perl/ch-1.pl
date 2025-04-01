#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 314 Task 1: Equal Strings
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( sum );

sub equal_strings( $s1, $s2, $s3 ) {
    my $n_equal = 0;
    ++$n_equal
	while $n_equal < length( $s1 )
	    && substr( $s2, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 )
	    && substr( $s3, $n_equal, 1 ) eq substr( $s1, $n_equal, 1 );
    return -1
	if $n_equal == 0;
    return sum( map length( $_ ) - $n_equal, $s1, $s2, $s3 );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is equal_strings( "abc", "abb", "ab" ), 2,
    'Example 1: equal_strings( "abc", "abb", "ab" ) == 2';
is equal_strings( "ayz", "cyz", "xyz" ), -1,
    'Example 2: equal_strings( "ayz", "cyz", "xyz" ) == -1';
is equal_strings( "yza", "yzb", "yzc" ), 3,
    'Example 3: equal_strings( "yza", "yzb", "yzc" ) == 3';

done_testing;
