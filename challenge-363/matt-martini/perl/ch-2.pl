#!/usr/bin/env perl

# You are given an IPv4 address and an IPv4 network (in CIDR format).

# Write a script to determine whether both are valid and the address falls
# within the network. For more information see the Wikipedia article.
# https://en.wikipedia.org/wiki/IPv4

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

my $to255_re = qr<\b(?:[01]?\d\d?|2[0-4]\d|25[0-5])\b>;
my $ip_re    = qr<^$to255_re(?:\.$to255_re){3}\b>;

my $to32_re    = qr<\b(?:[012]?\d|3[0-2])\b>;
my $network_re = qr<^$ip_re/$to32_re>;

sub ip2bin {
    my $ip = shift;
    return unpack "B32", pack "C4", split( /[.]/, $ip );
}

sub prefix2bin {
    my $prefix = shift;
    my $mask   = 0xffffffff << ( 32 - $prefix );
    return unpack( "B32", pack( "N", $mask ) );
}

sub subnet_sheriff {
    my ( $ip_addr, $domain ) = @{ $_[0] };
    say 'Input: $ip_addr = "' . $ip_addr . q{"};
    say '       $domain  = "' . $domain . q{"};

    my $result = 'false';

    if ( $ip_addr =~ $ip_re && $domain =~ $network_re ) {
        my $addr = ip2bin($ip_addr);

        my ( $class, $prefix ) = split '/', $domain;
        my $bclass = ip2bin($class);

        my $mask = prefix2bin($prefix);
        my $masked_ip = $addr & $mask;

        if ( $masked_ip == $bclass ) {
            $result = 'true';
        }
    }

    say 'Output: ' . $result;
    return $result;
}

my @examples = (
                 {  in   => [ '192.168.1.45', '192.168.1.0/24' ],
                    out  => 'true',
                    name => 'example 1'
                 },

                 {  in   => [ '10.0.0.256', '10.0.0.0/24' ],
                    out  => 'false',
                    name => 'example 2'
                 },

                 {  in   => [ '172.16.8.9', '172.16.8.9/32' ],
                    out  => 'true',
                    name => 'example 3'
                 },

                 {  in   => [ '172.16.4.5', '172.16.0.0/14' ],
                    out  => 'true',
                    name => 'example 4'
                 },

                 {  in   => [ '192.0.2.0', '192.0.2.0/25' ],
                    out  => 'true',
                    name => 'example 5'
                 },
               );

is( subnet_sheriff( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

