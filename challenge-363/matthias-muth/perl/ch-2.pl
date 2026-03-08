#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 363 Task 2: Subnet Sheriff
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

sub subnet_sheriff( $ip_addr, $domain ) {
    # Define a regex for a number with up to three digits (0..999)
    # and no leading zeroes.
    my $n3 = qr/(?: 0 | [1-9]\d{0,2} )/x;

    # Extract the numbers.
    my @ip_addr_parts = $ip_addr =~ m<^($n3)\.($n3)\.($n3)\.($n3)$>;
    my @domain_parts  = $domain  =~ m<^($n3)\.($n3)\.($n3)\.($n3)/($n3)$>;
    my $network_mask_bits = pop @domain_parts;
    return false
        unless scalar grep( $_ <= 255, @ip_addr_parts, @domain_parts ) == 8
            && $network_mask_bits <= 32;

    # Convert the respective four parts into a 32-bit integer,
    # and calculate the 32-bit network and host masks.
    my $host_addr    = unpack "N", pack "CCCC", @ip_addr_parts;
    my $network      = unpack "N", pack "CCCC", @domain_parts;
    my $host_mask    = 0xFFFFFFFF >> $network_mask_bits;
    my $network_mask = ~ $host_mask & 0xFFFFFFFF;

    return ( $network & $host_mask ) == 0
        && ( $host_addr & $network_mask ) == $network;
}

use Test2::V0 qw( -no_srand );

is subnet_sheriff( "999.168.1.45", "999.168.1.0/24" ), F,
    'Test 1: no number can be larger than 255';
is subnet_sheriff( "192.168.1.45", "192.168.1.99/24" ), F,
    'Test 2: the host part of the network address must be all zeroes';
is subnet_sheriff( "192.168.1.45", "192.168.1.0/64" ), F,
    'Test 3: maximum network mask size is 32';

is subnet_sheriff( "192.168.1.45", "192.168.1.0/24" ), T,
    'Example 1: subnet_sheriff( "192.168.1.45", "192.168.1.0/24" ) is true';
is subnet_sheriff( "10.0.0.256", "10.0.0.0/24" ), F,
    'Example 2: subnet_sheriff( "10.0.0.256", "10.0.0.0/24" ) is false';
is subnet_sheriff( "172.16.8.9", "172.16.8.9/32" ), T,
    'Example 3: subnet_sheriff( "172.16.8.9", "172.16.8.9/32" ) is true';
is subnet_sheriff( "172.16.4.5", "172.16.0.0/14" ), T,
    'Example 4: subnet_sheriff( "172.16.4.5", "172.16.0.0/14" ) is true';
is subnet_sheriff( "192.0.2.0", "192.0.2.0/25" ), T,
    'Example 5: subnet_sheriff( "192.0.2.0", "192.0.2.0/25" ) is true';

done_testing;
