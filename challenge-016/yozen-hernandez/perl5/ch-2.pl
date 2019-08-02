#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(signatures);
no warnings "experimental::signatures";
use Carp;
use Digest::SHA qw(sha256);
use Math::BigInt try => 'GMP';

# Write a script to validate a given bitcoin address. Most Bitcoin addresses are
# 34 characters. They consist of random digits and uppercase and lowercase
# letters, with the exception that the uppercase letter “O”, uppercase letter
# “I”, lowercase letter “l”, and the number “0” are never used to prevent visual
# ambiguity. A bitcoin address encodes 25 bytes. The last four bytes are a
# checksum check. They are the first four bytes of a double SHA-256 digest of
# the previous 21 bytes. For more information, please refer wiki page. Here are
# some valid bitcoin addresses:

#     1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
#     3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

my @b58_chars = split //,
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
my %b58 = map { $b58_chars[$_] => $_ } ( 0 .. 57 );

sub b58_decode ($btc_addr) {
    my $val = Math::BigInt->new();
    my $base = Math::BigInt->new(58);
    my @btc_arr = reverse split( //, $btc_addr );

    while ( my ( $i, $v ) = each @btc_arr ) {
        croak("Invalid bitcoin address") unless (exists $b58{$v});
        $val = $base->copy()->bpow($i)->bmuladd($b58{$v}, $val);
    }

    # Decode value to bytes
    my $decoded = $val->to_bytes();

    # 0-padding
    $decoded = (chr(0) x (25-length($decoded))) . $decoded;
    return $decoded;
}

sub btc_valid ($btc_addr) {
    # return undef unless ( $btc_addr =~ m/[1-9a-km-zA-HJ-NP-Z]{26,34}/ );

    my $decoded = b58_decode($btc_addr);

  # The last four bytes are a checksum check. They are the first four bytes of
  # a double SHA-256 digest of the previous 21 bytes.
    my $checksum = substr $decoded, -4;
    my $data     = substr $decoded, 0, 21;

    return ( $checksum eq substr(sha256( sha256($data) ), 0, 4) ) ? substr($decoded, 0, 1) : undef;
}

use Test::More tests => 4;
is(unpack("H*", b58_decode('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2')), lc'0077BFF20C60E522DFAA3350C39B030A5D004E839AF415766B', "b58 decode works");
is(unpack("H*", b58_decode('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy')), lc'05B472A266D0BD89C13706A4132CCFB16F7C3B9FCB81FCFC02', "b58 decode works");
ok( defined btc_valid('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2'),
    'First test address is valid' );
ok( defined btc_valid('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'),
    'Second test address is valid' );
