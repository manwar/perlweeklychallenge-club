#!/usr/bin/env perl

# You are given an array of strings.

# Write a script to return all strings that are a substring of another
# word in the given array in the order they occur.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub match_string {
    my (@words) = @_;
    diag 'Input: @words = (' . join( ', ', @words ) . ")\n";

    my @results;
    my %dups;

    MATCH:
    foreach ( my $i = 0; $i <= $#words; $i++ ) {
        next MATCH if (++$dups{$words[$i]} > 1);
        COMPARE:
        foreach ( my $j = 0; $j <= $#words; $j++ ) {
            next COMPARE if ( $i == $j );
            my $indx = index( $words[$j], $words[$i] );
            if ( $indx != -1 ) {
                push @results, $words[$i];
                next MATCH;
            }
        }
    }

    diag 'Output: @results = (' . join( ', ', @results ) . ")\n";
    return \@results;
}

is(
    match_string(
                   ( "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat" )
                ),
    [ "cat", "dog", "dogcat", "rat" ],
    'example 1'
  );
is(
    match_string(
                      ( "hello", "hell", "world", "wor", "ellow", "elloworld" )
                ),
    [ "hell", "world", "wor", "ellow" ],
    'example 2'
  );
is(
    match_string( ( "a", "aa", "aaa", "aaaa" ) ),
    [ "a", "aa", "aaa" ],
    'example 3'
  );
is(
    match_string(
                      ( "flower", "flow", "flight", "fl", "fli", "ig", "ght" )
                ),
    [ "flow", "fl", "fli", "ig", "ght" ],
    'example 4'
  );
is(
    match_string(
                      ( "car", "carpet", "carpenter", "pet", "enter", "pen", "pent" )
                ),
    [ "car", "pet", "enter", "pen", "pent" ],
    'example 5'
  );
