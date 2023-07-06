#!/usr/bin/env perl
# Task 1: Special Notes

# You are given two strings, $source and $target.

# Write a script to find out if using the characters (only once) from
# source, a target string can be created.

use 5.12.0;
use Test::More;

cmp_ok( special_notes( "abc",               "xyz" ),  "==", 0, "Example 1" );
cmp_ok( special_notes( "scriptinglanguage", "perl" ), "==", 1, "Example 2" );
cmp_ok( special_notes( "aabbcc",            "abc" ),  "==", 1, "Example 3" );
done_testing();

sub special_notes {
    my ( $source, $target ) = @_;
    my %characters;
    my $special = 1;

    map { $characters{$_}++ } ( split //, $source );

    for ( split //, $target ) {
        if ( $characters{$_} ) {
            $characters{$_}--;
        }
        else {
            $special = 0;
            last;
        }
    }
    return $special;
}
