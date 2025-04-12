#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 316 Task 1: Circular
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all );

sub circular( @list ) {
    return all { substr( $list[ $_ - 1 ], -1 ) eq substr( $list[$_], 0, 1 ) }
	1..$#list;
}

use Test2::V0 qw( -no_srand );

is circular( "perl", "loves", "scala" ), T,
    'Example 1: circular( "perl", "loves", "scala" ) is true';
is circular( "love", "the", "programming" ), F,
    'Example 2: circular( "love", "the", "programming" ) is false';
is circular( "java", "awk", "kotlin", "node.js" ), T,
    'Example 3: circular( "java", "awk", "kotlin", "node.js" ) is true';

done_testing;
