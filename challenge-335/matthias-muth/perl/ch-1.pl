#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 335 Task 1: Common Characters
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Set::Bag;

sub common_characters( @words ) {
    my $common_bag = Set::Bag->new( map { ( $_ => 1 ) } split //, $words[0] );
    $common_bag &= Set::Bag->new( map { ( $_ => 1 ) } split //, $_ )
        for @words[1..$#words];
    return map +( $_ ) x $common_bag->grab( $_ ),
        sort $common_bag->elements;
}

use Test2::V0 qw( -no_srand );

is [ common_characters( "bella", "label", "roller" ) ], [ "e", "l", "l" ],
    'Example 1: common_characters( "bella", "label", "roller" ) == ("e", "l", "l")';
is [ common_characters( "cool", "lock", "cook" ) ], [ "c", "o" ],
    'Example 2: common_characters( "cool", "lock", "cook" ) == ("c", "o")';
is [ common_characters( "hello", "world", "pole" ) ], [ "l", "o" ],
    'Example 3: common_characters( "hello", "world", "pole" ) == ("l", "o")';
is [ common_characters( "abc", "def", "ghi" ) ], [  ],
    'Example 4: common_characters( "abc", "def", "ghi" ) == ()';
is [ common_characters( "aab", "aac", "aaa" ) ], [ "a", "a" ],
    'Example 5: common_characters( "aab", "aac", "aaa" ) == ("a", "a")';

done_testing;
