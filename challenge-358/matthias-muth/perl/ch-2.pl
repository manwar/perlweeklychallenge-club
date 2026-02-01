#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 358 Task 2: Encrypted String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub encrypted_string( $str, $int ) {
    return join "",
        map {
            my $start = ord( /^[a-z]/ ? 'a' : /^[A-Z]/ ? 'A' : "\0" );
            $start
            ? chr( $start + ( ord( $_ ) - $start + $int ) % 26 )
            : $_
        } split //, $str;
}

use Test2::V0 qw( -no_srand );

is encrypted_string( "abc", 1 ), "bcd",
    'Example 1: encrypted_string( "abc", 1 ) eq "bcd"';
is encrypted_string( "xyz", 2 ), "zab",
    'Example 2: encrypted_string( "xyz", 2 ) eq "zab"';
is encrypted_string( "abc", 27 ), "bcd",
    'Example 3: encrypted_string( "abc", 27 ) eq "bcd"';
is encrypted_string( "hello", 5 ), "mjqqt",
    'Example 4: encrypted_string( "hello", 5 ) eq "mjqqt"';
is encrypted_string( "perl", 26 ), "perl",
    'Example 5: encrypted_string( "perl", 26 ) eq "perl"';
is encrypted_string( "Hello World!", 27 ), "Ifmmp Xpsme!",
    'Own Test 1: encrypted_string( "Hello World!", 27 ) eq "Ifmmp Xpsme!"';
is encrypted_string( "theweeklychallenge", 358 ), "nbyqyyefswbuffyhay",
    'Own Test 2: encrypted_string( "theweeklychallenge", 358 )'
        . ' eq "nbyqyyefswbuffyhay"';

done_testing;
