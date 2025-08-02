#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 272 Task 1: Defrang IP Address
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub defrang_ip_address( $ip ) {
    return $ip =~ s/\./[.]/gr;
}

use Test2::V0 qw( -no_srand );
is defrang_ip_address( "1.1.1.1" ), "1[.]1[.]1[.]1",
    'Example 1: defrang_ip_address( "1.1.1.1" ) == "1[.]1[.]1[.]1"';
is defrang_ip_address( "255.101.1.0" ), "255[.]101[.]1[.]0",
    'Example 2: defrang_ip_address( "255.101.1.0" ) == "255[.]101[.]1[.]0"';
done_testing;
