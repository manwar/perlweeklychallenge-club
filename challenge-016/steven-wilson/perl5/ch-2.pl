#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-13
# Week: 016
#
# Task #2
# Write a script to validate a given bitcoin address. Most Bitcoin
# addresses are 34 characters. They consist of random digits and
# uppercase and lowercase letters, with the exception that the uppercase
# letter “O”, uppercase letter “I”, lowercase letter “l”, and the number
# “0” are never used to prevent visual ambiguity. A bitcoin address
# encodes 25 bytes. The last four bytes are a checksum check. They are
# the first four bytes of a double SHA-256 digest of the previous 21
# bytes. For more information, please refer wiki page. Here are some
# valid bitcoin addresses:
# https://en.bitcoin.it/wiki/Address
#
# 1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2
# 3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy

use strict;
use warnings;
use bigint;
use Crypt::Digest::SHA256 qw/ sha256 sha256_hex /;
use Test::More;

my %alphabets = (
    58 => [
        qw/ 1 2 3 4 5 6 7 8 9 A B C D E F G H J K L M N P Q R S T U V W X Y
            Z a b c d e f g h i j k m n o p q r s t u v w x y z /
    ],
    16 => [qw/ 0 1 2 3 4 5 6 7 8 9 a b c d e f /],
    10 => [qw/ 0 1 2 3 4 5 6 7 8 9 /],
);

ok( is_valid_bitcoin_address("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2") eq 1,
    "test valid address" );
ok( is_valid_bitcoin_address("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy") eq 1,
    "test valid address" );
ok( is_valid_bitcoin_address("1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs") eq 1,
    "test valid address" );
ok( is_valid_bitcoin_address("1AGNa15ZQXAZUgFiqJ2i7Z2DPU2J6hW62i") eq 1,
    "test valid address" );

ok( is_valid_bitcoin_address("1dn9TcK68q7XKZIx3d4Gx94vvE87DKizXX") eq 0,
    "test invalid address" );

done_testing();

sub is_valid_bitcoin_address {
    my $address = shift;
    my $address_base16 = base_encode( 16, base_decode( 58, $address ) );

    # The last four bytes are a checksum check
    my $checksum = substr( $address_base16, -8 );

    my $RIPEMD_160_hash = substr( $address_base16, 0, -8 );
    my $extended_RIPEMD_160_hash = $RIPEMD_160_hash;

    # Add version byte in front of RIPEMD-160 hash to total 21 bytes
    while ( length $extended_RIPEMD_160_hash < 42 ) {
        $extended_RIPEMD_160_hash = "0" . $extended_RIPEMD_160_hash;
    }

    # Extract pairs of hexadecimal characters from the string.
    # Convert each pair to a decimal number.
    # Pack the number as a byte.
    my @bytes = map { pack( 'C', hex($_) ) }
        ( $extended_RIPEMD_160_hash =~ /(..)/g );

    # perform double SHA-256 digest of the previous 21 bytes
    my $sha256_raw = sha256(@bytes);
    my $sha256_hex = sha256_hex($sha256_raw);

    # Take the first 4 bytes of the second SHA-256 hash. This is the
    # address checksum
    my $calculated_checksum = substr( $sha256_hex, 0, 8 );

    if ( $checksum eq $calculated_checksum ) {
        return 1;
    }
    else {
        return 0;
    }
}

# convert from base10 to a given base
sub base_encode {
    my ( $base, $number ) = @_;
    my $answer = "";
    while ( $number > $base - 1 ) {
        $answer = $alphabets{$base}[ ( $number % $base ) ] . $answer;
        $number = $number / $base;
    }
    $answer = $alphabets{$base}[$number] . $answer;
    return $answer;
}

# convert from a given base to base10
sub base_decode {
    my ( $base, $number ) = @_;
    my @number_as_array = split( //, $number );
    my $number_length   = @number_as_array;
    my $answer          = 0;
    my $counter         = 0;
    my $digit_in_base10;
    for ( my $i = $number_length - 1; $i >= 0; $i-- ) {
        ($digit_in_base10)
            = grep { $alphabets{$base}[$_] eq $number_as_array[$counter] }
            ( 0 .. $base - 1 );
        $answer += $digit_in_base10 * $base**$i;
        $counter++;
    }
    return $answer;
}
