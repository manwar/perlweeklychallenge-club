#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK2
#
# Task 2: Subnet Sheriff
# ======================
#
# You are given an IPv4 address and an IPv4 network (in CIDR format).
#
# Write a script to determine whether both are valid and the address falls
# within the network. For more information see the Wikipedia article.
#
## Example 1
##
## Input: $ip_addr = "192.168.1.45"
##        $domain  = "192.168.1.0/24"
## Output: true
#
#
## Example 2
##
## Input: $ip_addr = "10.0.0.256"
##        $domain  = "10.0.0.0/24"
## Output: false
#
#
## Example 3
##
## Input: $ip_addr = "172.16.8.9"
##        $domain  = "172.16.8.9/32"
## Output: true
#
#
## Example 4
##
## Input: $ip_addr = "172.16.4.5"
##        $domain  = "172.16.0.0/14"
## Output: true
#
#
## Example 5
##
## Input: $ip_addr = "192.0.2.0"
##        $domain  = "192.0.2.0/25"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# At first, we make sure the ip_addr and domain are valid:
# - they have the right amount of digits and "."
# - the domain has a "/" and one or two more digits
# - each number in the ip_addr or the IP part of the domain is
#   in the range 0..255
# - the netmask is in the range 1..32
# Now, we just need to check whether ip_addr is in the range
# given by domain. For this, we turn both into binary form
# and check whether the first mask many digits are the same
# for both.

use v5.36;

subnet_sheriff("192.168.1.45", "192.168.1.0/24");
subnet_sheriff("10.0.0.256", "10.0.0.0/24");
subnet_sheriff("172.16.8.9", "172.16.8.9/32");
subnet_sheriff("172.16.4.5", "172.16.0.0/14");
subnet_sheriff("192.0.2.0", "192.0.2.0/25");

sub subnet_sheriff($ip_addr, $domain) {
    say "Input: $ip_addr, $domain";
    return say "Output: false" unless $ip_addr =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
    return say "Output: false" unless $domain =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}/;
    return say "Output: false" unless ip_ok($ip_addr);
    return say "Output: false" unless domain_ok($domain);
    my @ip_binary = to_binary($ip_addr);
    my ($ip_part, $mask) = split /\//, $domain;
    my @domain_binary = to_binary($ip_part);
    foreach my $digit (0..$mask-1) {
        return say "Output: false" unless $ip_binary[$digit] == $domain_binary[$digit];
    }
    say "Output: true";
}

sub ip_ok($ip) {
    my ($i,$j,$k,$l) = split /\./, $ip;
    return 0 if $i > 255;
    return 0 if $j > 255;
    return 0 if $k > 255;
    return 0 if $l > 255;
    return 1;
}

sub domain_ok($domain) {
    my ($ip, $mask) = split /\//, $domain;
    return 0 if $mask > 32;
    return 0 if $mask < 1;
    return ip_ok($ip);
}

sub to_binary($ip) {
    my @binary = ();
    my ($i,$j,$k,$l) = split /\./, $ip;
    foreach my $part (($i, $j, $k, $l)) {
        foreach my $num ((128,64,32,16,8,4,2,1) ) {
            if($part >= $num) {
                push @binary, 1;
                $part -= $num;
            } else {
                push @binary, 0;
            }
        }
    }
    return @binary;
}
