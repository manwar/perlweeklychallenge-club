#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-01
# Week: 015
# Challenge: #2
#
# Write a script to implement Vigenère cipher. The script should be able
# encode and decode. Checkout wiki page for more information.
# https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
#   Usage:  $ perl ch-2.pl OPERATION KEYWORD MESSAGE
#           $ perl ch-2.pl -e LEMONS ATTACKATDAWN  # encrypt a message
#           $ perl ch-2.pl -d LEMONS LXFOPCLXPOJF  # decrypt a message

use strict;
use warnings;
use feature qw / say /;
use Test::More;

my ( $operation, $keyword, $in_text ) = ( $ARGV[0], $ARGV[1], $ARGV[2] );
my $out_text;
my %operations = (
    '-e' => 'encrypted',
    '-d' => 'decrypted',
);

ok( encode( "ATTACKATDAWN", "LEMON" ) eq "LXFOPVEFRNHR", "encode working" );
ok( decode( "LXFOPVEFRNHR", "LEMON" ) eq "ATTACKATDAWN", "decode working" );
done_testing();

if ( $operation eq "-e" ) {
    $out_text = encode( $in_text, $keyword );
}
elsif ( $operation eq "-d" ) {
    $out_text = decode( $in_text, $keyword );
}
else {
    die "$operation is not a valid operation";
}

say "Message $operations{$operation} to '$out_text'";

sub encode {
    my ( $plaintext, $keyword ) = @_;
    my $cyphertext;
    for my $i ( 0 .. ( ( length $plaintext ) - 1 ) ) {
        my $mi = ord( substr( $plaintext, $i, 1 ) ) - 65;
        my $ki = ord( substr( $keyword, ( $i % length $keyword ), 1 ) ) - 65;
        $cyphertext .= chr( ( ( $mi + $ki ) % 26 ) + 65 );
    }
    return $cyphertext;
}

sub decode {
    my ( $cyphertext, $keyword ) = @_;
    my $plaintext;
    for my $i ( 0 .. ( ( length $cyphertext ) - 1 ) ) {
        my $ci = ord( substr( $cyphertext, $i, 1 ) ) - 65;
        my $ki = ord( substr( $keyword, ( $i % length $keyword ), 1 ) ) - 65;
        $plaintext .= chr( ( ( $ci - $ki ) % 26 ) + 65 );
    }
    return $plaintext;
}
