#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(say state signatures);
no warnings "experimental::signatures";
use Carp;

# Write a script to implement Vigenère cipher. The script should be able encode
# and decode. Checkout wiki page for more information.

my %tabula;
@tabula{ "A" .. "Z" } = ( 0 .. 25 );

sub vigenere (%args) {
    croak "Must supply the 'message' and 'key' arguments to this function.\n"
        unless ( exists $args{message} && exists $args{key} );

    my @message = split //, uc($args{message});
    my @key  = split //, uc($args{key});
    my $decode = ( exists $args{decode} && $args{decode} != 0 ) || -1;
    return join "", map {
        ( "A" .. "Z" )[
            ( $tabula{ $message[$_] }
                    + ( ( -1 * $decode ) * $tabula{ $key[ $_ % @key ] } ) ) %
            keys %tabula
        ]
    } ( 0 .. @message - 1 );
}

sub encode_vigenere {
    my %args = @_;
    vigenere(%args, decode => 0);
}

sub decode_vigenere {
    my %args = @_;
    vigenere(%args, decode => 1);
}

my $message = $ARGV[0] // "ATTACKATDAWN";
my $key  = $ARGV[1] // "LEMON";

# Encrypt
my $encrypted = encode_vigenere( message => $message, key => $key );
say "Encrypted: $encrypted";

# Decrypt
my $decoded = decode_vigenere( message => $encrypted, key => $key, decode => 0 );
say "Decrypted: $decoded";
