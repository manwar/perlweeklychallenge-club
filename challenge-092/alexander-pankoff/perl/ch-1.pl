#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Test::Simple tests => 3;

{
    my @test_data = (
        [ 'abc' => 'xyz', 1 ],    #
        [ 'abb' => 'xyy', 1 ],
        [ 'sum' => 'add', 0 ],
    );

    for my $pair ( @test_data ) {
        my ( $a, $b, $expect ) = @$pair;
        ok(
            is_isomorphic( $a, $b ) == $expect,    #
            "'$a' is " . ( $expect ? '' : 'not ' ) . "isomorpic to '$b'"
        );
    }
}

# this algorithm was taken from the explanation link given in the challenge:
# https://www.educative.io/edpresso/how-to-check-if-two-strings-are-isomorphic
sub is_isomorphic ( $a, $b ) {

    # there is no isomorphism if both strings have different lengths
    return 0 if length( $a ) != length( $b );

    # we will store the mapping from $a to $b in here
    my %a2b;

    # we use another hash to keep track of the inverse mapping
    my %b2a;

    # we will check each character in $a and $b for conflicts with the isomorphism coditions
    for my $i ( 0 ... length( $a ) ) {
        my $c_a = substr( $a, $i, 1 );
        my $c_b = substr( $b, $i, 1 );

        # there is already an entry for the current char from a
        if ( exists $a2b{$c_a} ) {

            # if the character from a was mapped to a different character from
            # $c_b before we have a conflict.
            return 0 if $a2b{$c_a} ne $c_b;
        }

        # no mapping for $c_a found
        else {

            # if $c_b was mapped to a different character before we have a conflict.
            return 0 if exists $b2a{$c_b};

            # no conflict found. Store the mappings.
            $a2b{$c_a} = $c_b;
            $b2a{$c_b} = $c_a;
        }
    }

    # no conflict could be found. $a and $b are isomorphic
    return 1;
}

