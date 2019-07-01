#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-01
# Week: 015
# Challenge: #2
#
# Write a script to implement Vigenère cipher. The script should be able
# encode and decode. Checkout wiki page for more information.
# https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

use strict;
use warnings;
use feature qw / say /;
use Test::More;

my @alphabet = ("A".."Z");
my $plaintext;
my $keyword;
my $cyphertext;

ok( encode( "ATTACKATDAWN", "LEMON" ) eq "LXFOPVEFRNHR", "encode working" );
ok( decode( "LXFOPVEFRNHR", "LEMON" ) eq "ATTACKATDAWN", "decode working" );
done_testing();

sub encode {
    my ( $plaintext, $keyword ) = @_;
    my $cyphertext = "";
    for my $i (0..((length $plaintext) - 1)){
        (my $Mi) = grep { $alphabet[$_] eq substr($plaintext, $i, 1) } (0..@alphabet-1);
        (my $Ki) = grep { $alphabet[$_] eq substr($keyword, ($i % length $keyword), 1)} (0..@alphabet-1);
        $cyphertext .= $alphabet[($Mi + $Ki) % 26];
    }
    return $cyphertext;
}

sub decode {
    my ( $cyphertext, $keyword ) = @_;
    my $plaintext = "";
    for my $i (0..((length $cyphertext) - 1)){
        (my $Ci) = grep { $alphabet[$_] eq substr($cyphertext, $i, 1) } (0..@alphabet-1);
        (my $Ki) = grep { $alphabet[$_] eq substr($keyword, ($i % length $keyword), 1)} (0..@alphabet-1);
        $plaintext .= $alphabet[($Ci - $Ki) % 26];
    }
    return $plaintext;
}
