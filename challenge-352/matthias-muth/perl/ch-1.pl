#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 352 Task 1: Match String
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( uniq any );

sub match_string( @words ) {
    @words = uniq @words;
    return grep {
        my $string = $_;
        any { length $_ > length( $string ) && /$string/ } @words;
    } @words;
}

use Test2::V0 qw( -no_srand );

is [ match_string(
        "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat" ) ],
    [ "cat", "dog", "dogcat", "rat" ],
    'Example 1: match_string('
        . ' "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat" )'
        . ' == ("cat", "dog", "dogcat", "rat")';
is [ match_string( "hello", "hell", "world", "wor", "ellow", "elloworld" ) ],
    [ "hell", "world", "wor", "ellow" ],
    'Example 2: match_string('
        . ' "hello", "hell", "world", "wor", "ellow", "elloworld" )'
        . ' == ("hell", "world", "wor", "ellow")';
is [ match_string( "a", "aa", "aaa", "aaaa" ) ],
    [ "a", "aa", "aaa" ],
    'Example 3: match_string( "a", "aa", "aaa", "aaaa" ) == ("a", "aa", "aaa")';
is [ match_string( "flower", "flow", "flight", "fl", "fli", "ig", "ght" ) ],
    [ "flow", "fl", "fli", "ig", "ght" ],
    'Example 4: match_string('
        . ' "flower", "flow", "flight", "fl", "fli", "ig", "ght" )'
        . ' == ("flow", "fl", "fli", "ig", "ght")';
is [ match_string(
        "car", "carpet", "carpenter", "pet", "enter", "pen", "pent" ) ],
    [ "car", "pet", "enter", "pen", "pent" ],
    'Example 5: match_string('
        . ' "car", "carpet", "carpenter", "pet", "enter", "pen", "pent" )'
        . ' == ("car", "pet", "enter", "pen", "pent")';

done_testing;
