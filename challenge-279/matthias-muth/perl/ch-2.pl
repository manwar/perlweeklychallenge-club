#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 279 Task 2: Split String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Data::Dump qw( pp );

sub split_string( $str ) {
    # say pp scalar( () = $str =~ /[aeiou]/ig ) % 2 == 0;
    # say pp [ $str =~ /[aeiou]/ig ]->@* % 2 == 0;
    # say pp $str =~ tr/aeiouAEIOU/aeiouAEIOU/ % 2 == 0;

    my @vowels = $str =~ /[aeiou]/ig;
    return scalar @vowels % 2 == 0;
}

use Test2::V0 qw( -no_srand );
ok ! split_string( "perl" ),
    'Example 1: split_string( "perl" ) is false';
ok split_string( "book" ),
    'Example 2: split_string( "book" ) is true';
ok split_string( "good morning" ),
    'Example 3: split_string( "good morning" ) is true';
done_testing;
